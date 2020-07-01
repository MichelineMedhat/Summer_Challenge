import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String phoneNumber;
  String username;
  String password;
  String profilePicture;
  double score;

  User(
      {this.phoneNumber,
      this.username,
      this.password,
      this.profilePicture,
      this.score});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      phoneNumber: doc['phoneNumber'],
      username: doc['username'],
      password: doc['password'],
      profilePicture: doc['profilePicture'],
      score: doc['score'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'username': username,
      'password': password,
      'profilePicture': profilePicture,
      'score': score
    };
  }

  @override
  String toString() {
    return '''User {
      phoneNumber: $phoneNumber,
      username: $username,
      password: $password,
      profilePicture: $profilePicture,
      score: $score,
    }''';
  }
}
