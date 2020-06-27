import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String phoneNumber;
  String username;
  String password;
  String profilePicture;

  User({
    this.phoneNumber,
    this.username,
    this.password,
    this.profilePicture,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      phoneNumber: doc['phoneNumber'],
      username: doc['username'],
      password: doc['password'],
      profilePicture: doc['profilePicture']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'username': username,
      'password': password,
      'profilePicture':profilePicture,
    };
  }

  @override
  String toString() {
    return '''User {
      phoneNumber: $phoneNumber,
      username: $username,
      password: $password,
      profilePicture: $profilePicture,
    }''';
  }
}
