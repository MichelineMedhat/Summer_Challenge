import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String username;
  String userProfilePicture;
  String uri;
  String status;
  String hashtag;
  Timestamp timestamp;

  Post({
    this.username,
    this.userProfilePicture,
    this.uri,
    this.status,
    this.hashtag,
    this.timestamp
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
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
      'username': username,
      'userProfilePicture': userProfilePicture,
      'uri': uri,
      'status': status,
      'hashtag': hashtag,
      'timestamp':timestamp,
    };
  }

  @override
  String toString() {
    return '''Post {
      username: $username,
      userProfilePicture" $userProfilePicture,
      uri: $uri,
      status: $status,
      hashtag: $hashtag,
      timestamp: $timestamp,
    }''';
  }
}
