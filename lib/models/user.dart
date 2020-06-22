import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String username;
  String password;

  User({
    this.name,
    this.username,
    this.password,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      name: doc['name'],
      username: doc['username'],
      password: doc['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
    };
  }

  @override
  String toString() {
    return '''User {
      name: $name,
      username: $username,
      password: $password,
    }''';
  }
}
