import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String id;
  String title;
  String body;
  String hashtag;
  Timestamp timestamp;

  Challenge({this.title, this.body, this.hashtag, this.timestamp, this.id});

  factory Challenge.fromDocument(DocumentSnapshot doc) {
    return Challenge(
      id: doc['id'],
      title: doc['title'],
      body: doc['body'],
      hashtag: doc['hashtag'],
      timestamp: doc['timestamp'],
    );
  }

    Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'body': body,
      'hashtag': hashtag,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return '''Post {
      id: $id,
      title: $title,
      body" $body,
      hashtag: $hashtag,
      timestamp: $timestamp,
    }''';
  }
}
