import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;

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

  static Future<void> deleteHouse(House house) async {
    await fb.storage().refFromURL(house.imageUri).delete();
    await _db.collection('houses').document(house.houseName).delete();
  }

    static Future<Uri> uploadImageFile(
      Uint8List imageBytes, String houseName, String extenstion) async {
    fb.StorageReference storageRef =
        fb.storage().ref('houses/$houseName$extenstion');
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(imageBytes).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }
}
