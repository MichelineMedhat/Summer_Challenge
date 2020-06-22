import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<bool> isUsernameUsed(String username) async {
    final docs = await _db
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();

    return docs.documents.isNotEmpty;
  }
}
