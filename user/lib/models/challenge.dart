import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String title;
  String body;
  String hashtag;
  Timestamp timestamp;


  Challenge({this.title, this.body, this.hashtag, this.timestamp});

  factory Challenge.fromDocument(DocumentSnapshot doc) {
    return Challenge(
      title: doc['title'],
      body: doc['body'],
      hashtag: doc['hashtag'],
      timestamp: doc['timestamp'],
    );
  }

    Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'hashtag': hashtag,
      'timestamp': timestamp,
    };
  }

  @override
  String toString() {
    return '''Post {
      title: $title,
      body" $body,
      hashtag: $hashtag,
      timestamp: $timestamp,
    }''';
  }
}
