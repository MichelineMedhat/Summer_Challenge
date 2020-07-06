import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/house.dart';

class HouseRepository {
  static final Firestore _db = Firestore.instance;

  static Stream<List<House>> getAllHouses() {
    return _db.collection('houses').snapshots().map((snapshot) {
      return snapshot.documents.map((doc) => House.fromDocument(doc)).toList();
    });
  }

  static Future<void> addHouse(House house) async {
    await _db
        .collection('houses')
        .document(house.houseName)
        .setData(house.toMap());
  }

  static Future<void> updateHouse(House house) async {
    await _db
        .collection('houses')
        .document(house.houseName)
        .updateData(house.toMap());
  }

  static Future<void> deleteHouse(String houseName) async {
    await _db.collection('houses').document(houseName).delete();
  }
}
