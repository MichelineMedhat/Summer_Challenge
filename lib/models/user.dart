import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String username;
  String password;
  String profilePicture;

  User({
    this.name,
    this.username,
    this.password,
    this.profilePicture,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      name: doc['name'],
      username: doc['username'],
      password: doc['password'],
      profilePicture: doc['profilePicture']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'profilePicture':profilePicture,
    };
  }

  @override
  String toString() {
    return '''User {
      name: $name,
      username: $username,
      password: $password,
      profilePicture: $profilePicture,
    }''';
  }
}
