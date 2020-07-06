import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  String playlistUri;
  String houseName;
  String zoomLink;
  String zoomDate;
  String releaseDate;
  String imageUri;
  String roomId;
  String roomPassword;

  House(
      {this.playlistUri,
      this.houseName,
      this.zoomLink,
      this.zoomDate,
      this.releaseDate,
      this.imageUri,
      this.roomId,
      this.roomPassword});

  factory House.fromDocument(DocumentSnapshot doc) {
    return House(
      playlistUri: doc['playlistUri'],
      houseName: doc['houseName'],
      zoomLink: doc['zoomLink'],
      zoomDate: doc['zoomDate'],
      releaseDate: doc['releaseDate'],
      imageUri: doc['imageUri'],
      roomId: doc['roomId'],
      roomPassword: doc['roomPassword'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playlistUri': playlistUri,
      'houseName': houseName,
      'zoomLink': zoomLink,
      'zoomDate': zoomDate,
      'releaseDate': releaseDate,
      'imageUri': imageUri,
      'roomId': roomId,
      'roomPassword': roomPassword,
    };
  }

  @override
  String toString() {
    return '''Post {
      playlistUri: $playlistUri,
      houseName: $houseName,
      zoomLink" $zoomLink,
      zoomDate: $zoomDate,
      releaseDate: $releaseDate,
      imageUri: $imageUri,
      roomId: $roomId,
      roomPassword: $roomPassword
    }''';
  }
}
