import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/challenge.dart';

class ChallengeRepository {
  static final Firestore _db = Firestore.instance;

  static Stream<List<Challenge>> getAllChallenges() {
    return _db.collection('challenges').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => Challenge.fromDocument(doc)).toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }
}
