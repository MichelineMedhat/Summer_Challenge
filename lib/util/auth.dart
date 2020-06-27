import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Auth {
  static const _USERNAME = "username";
  static const _PASSWORD = "password";

  static final Auth _instance = Auth._();
  static final Firestore _db = Firestore.instance;
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static FutureOr<User> _user;

  FutureOr<User> get currentUser async {
    if (_user == null) {
      var data = await _getPrefs();
      if (data[_USERNAME].isNotEmpty && data[_PASSWORD].isNotEmpty) {
        await _fetchData(data[_USERNAME], data[_PASSWORD]);
      }
    }
    return await _user;
  }

  static Auth get instance => _instance;

  Auth._();

  DocumentReference _getDocRef(String username) {
    return _db.collection('users').document(username);
  }

  Future<void> signIn(String username, String password) async {
    await _fetchData(username, password);
    await _setPrefs(username, password);
  }

  Future<void> _fetchData(String username, String password) async {
    var doc = await _getDocRef(username).get();
    if (!doc.exists) throw AuthException("User not found");
    password == doc['password']
        ? _user = User.fromDocument(doc)
        : throw AuthException("Wrong credentials");
  }

  Future<void> signUp(User user) async {
    await _getDocRef(user.username).setData(user.toMap());
    await _setPrefs(user.username, user.password);
    _user = user;
  }

  Future<void> signOut() async {
    await _setPrefs(null, null);
    _user = null;
  }

  Future<Map<String, String>> _getPrefs() async {
    var prefs = await _prefs;
    return {
      _USERNAME: prefs.getString(_USERNAME) ?? "",
      _PASSWORD: prefs.getString(_PASSWORD) ?? ""
    };
  }

  Future<void> _setPrefs(String username, String password) async {
    var prefs = await _prefs;
    prefs.setString(_USERNAME, username);
    prefs.setString(_PASSWORD, password);
  }

  Future<void> updateProfile(User user) async {
    await _getDocRef(user.username).updateData({
    'phoneNumber': user.phoneNumber,
    'username': user.username,
    'password': user.password,
    'profilePicture': user.profilePicture,
  });
  }
}

class AuthException implements Exception {
  String message;

  AuthException(this.message);

  @override
  String toString() {
    return 'AuthException{message: $message}';
  }
}
