import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String username;
  String uri;
  String status;
  String hashtag;
  Timestamp timestamp;

  Post({
    this.username,
    this.uri,
    this.status,
    this.hashtag,
    this.timestamp
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      username: doc['username'],
      uri: doc['uri'],
      status: doc['status'],
      hashtag: doc['hashtag'],
      timestamp: doc['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      username: username,
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
      uri: $uri,
      status: $status,
      hashtag: $hashtag,
      timestamp: $timestamp,
    }''';
  }
}
