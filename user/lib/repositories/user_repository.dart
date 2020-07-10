import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;

import '../models/user.dart';
import '../util/auth.dart';

class UserRepository {
  static final Auth _auth = Auth.instance;
  static final Firestore _db = Firestore.instance;
  static DocumentSnapshot lastPostSnapshot;

  Future<void> signIn(String username, String password) async {
    await _auth.signIn(username, password);
  }

  Future<void> signUp(User user) async {
    await _auth.signUp(user);
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser;
    return currentUser != null;
  }

  Future<User> getUser() async {
    return await _auth.currentUser;
  }

  Future<void> updateProfile(User user) async {
    return await _auth.updateProfile(user);
  }

  static Future<bool> isUsernameUsed(String username) async {
    final docs = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();

    return docs.documents.isNotEmpty;
  }

  Future<Uri> uploadImageFile(
      Uint8List imageBytes, String imageName, String extenstion) async {
    fb.StorageReference storageRef =
        fb.storage().ref('images/$imageName$extenstion');
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(imageBytes).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  Future<void> deleteProfilePicture(String uri) async {
    await fb.storage().refFromURL(uri).delete();
  }

  Future<void> updateProfilePicture(User user, Uint8List imageBytes,
      String imageName, String extenstion) async {
    if (user.profilePicture != null) {
      await deleteProfilePicture(user.profilePicture);
    }
    uploadImageFile(imageBytes, imageName, extenstion).then((uri) {
      user.profilePicture = uri.toString();
      _db
          .collection('users')
          .document(user.username)
          .updateData({'profilePicture': user.profilePicture});

      _db
          .collection('posts')
          .where('username', isEqualTo: user.username)
          .getDocuments()
          .then((value) {
        value.documents.forEach((element) async {
          await _db
              .collection("posts")
              .document(element["id"])
              .updateData({'userProfilePicture': user.profilePicture});
        });
      });
    });
  }

  static Future<String> getProfilePicture(String username) async {
    var docRef = await _db.collection('users').document(username).get();
    return docRef["profilePicture"];
  }

  static Stream<List<User>> getScores() {
    if (lastPostSnapshot == null) {
      return _db
          .collection('users')
          .orderBy("score", descending: true)
          .orderBy("username")
          .limit(10)
          .snapshots()
          .map((snapshot) {
        if (snapshot.documents.length != 0) {
          lastPostSnapshot = snapshot.documents[snapshot.documents.length - 1];
        }
        return snapshot.documents.map((doc) => User.fromDocument(doc)).toList()
          ..sort((a, b) => b.score.compareTo(a.score));
      });
    } else {
      return _db
          .collection('users')
          .orderBy("score", descending: true)
          .orderBy("username")
          .startAfterDocument(lastPostSnapshot)
          .limit(10)
          .snapshots()
          .map((snapshot) {
        if (snapshot.documents.length != 0) {
          lastPostSnapshot = snapshot.documents[snapshot.documents.length - 1];
        }
        return snapshot.documents.map((doc) => User.fromDocument(doc)).toList()
          ..sort((a, b) => b.score.compareTo(a.score));
      });
    }
  }

  static void disposePagination() {
    lastPostSnapshot = null;
  }
}
