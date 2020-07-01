import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String username;
  String userProfilePicture;
  String uri;
  String status;
  String hashtag;
  Timestamp timestamp;
  String graded;

  Post(
      {this.id,
      this.username,
      this.userProfilePicture,
      this.uri,
      this.status,
      this.hashtag,
      this.timestamp,
      this.graded});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc['id'],
      username: doc['username'],
      userProfilePicture: doc['userProfilePicture'],
      uri: doc['uri'],
      status: doc['status'],
      hashtag: doc['hashtag'],
      timestamp: doc['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'userProfilePicture': userProfilePicture,
      'uri': uri,
      'status': status,
      'hashtag': hashtag,
      'timestamp': timestamp,
      'graded': graded,
    };
  }

  @override
  String toString() {
    return '''Post {
      id: $id,
      username: $username,
      userProfilePicture" $userProfilePicture,
      uri: $uri,
      status: $status,
      hashtag: $hashtag,
      timestamp: $timestamp,
      graded: $graded
    }''';
  }
}
