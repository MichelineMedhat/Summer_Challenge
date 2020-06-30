import 'package:admin/blocs/challenge_bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/challenge.dart';

class ChallengeRepository {
  static final Firestore _db = Firestore.instance;

  static Stream<List<Challenge>> getAllChallenges() {
    return _db.collection('challenges').snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Challenge.fromDocument(doc))
          .toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  static Future<void> addChallenge(Challenge challenge) async {
    DocumentReference ref = _db.collection('challenges').document();
    challenge.id = ref.documentID;
    await ref.setData(challenge.toMap());
  }

  static Future<void> deleteChallenge(String id) async {
    await _db.collection('challenges').document(id).delete();
  }
}
