import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;

import '../models/user.dart';
import '../util/auth.dart';

class UserRepository {
  static final Auth _auth = Auth.instance;
  static final Firestore _db = Firestore.instance;

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

  Future<void> updateProfile( User user) async{
    return await _auth.updateProfile(user);
  }

  static Future<bool> isUsernameUsed(String username) async {
    final docs = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();

    return docs.documents.isNotEmpty;
  }
 
  Future<Uri> uploadImageFile(Uint8List imageBytes, String imageName, String extenstion) async {
    fb.StorageReference storageRef = fb.storage().ref('images/$imageName$extenstion');
    fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(imageBytes).future;
    
    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
}

}
