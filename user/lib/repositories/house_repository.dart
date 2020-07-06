import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/house.dart';

class HouseRepository {
  static final Firestore _db = Firestore.instance;

  static Stream<List<House>> getAllHouses() {
    return _db.collection('houses').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => House.fromDocument(doc)).toList();
    });
  }
}
