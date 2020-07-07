import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;

import '../models/user.dart';

class UserRepository {
  static final Firestore _db = Firestore.instance;

  static Stream<List<User>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => User.fromDocument(doc)).toList()
        ..sort((a, b) => b.username.compareTo(a.username));
    });
  }

  static Stream<List<User>> getUser(String username) {
    return _db
        .collection('users')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((doc) => User.fromDocument(doc)).toList();
    });
  }

  static Future<void> deleteUser(User user) async {
    await _db
        .collection('posts')
        .where("username", isEqualTo: user.username)
        .getDocuments()
        .then((value) => {
              value.documents.forEach((element) async {
                if (element["uri"] != null) {
                  await fb.storage().refFromURL(element["uri"]).delete();
                }
                await _db.collection("posts").document(element["id"]).delete();
              })
            });

    if (user.profilePicture != null) {
      await fb.storage().refFromURL(user.profilePicture).delete();
    }
    await _db.collection('users').document(user.username).delete();
  }
}
