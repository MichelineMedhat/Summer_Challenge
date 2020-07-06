import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  final String playlistUri;
  final String houseName;
  final String zoomLink;
  final String zoomDate;
  final String releaseDate;
  final String imageName;
  final String roomId;
  final String roomPassword;

  House(
      {this.playlistUri,
      this.houseName,
      this.zoomLink,
      this.zoomDate,
      this.releaseDate,
      this.imageName,
      this.roomId,
      this.roomPassword});

  factory House.fromDocument(DocumentSnapshot doc) {
    return House(
      playlistUri: doc['playlistUri'],
      houseName: doc['houseName'],
      zoomLink: doc['zoomLink'],
      zoomDate: doc['zoomDate'],
      releaseDate: doc['releaseDate'],
      imageName: doc['imageName'],
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
      'imageName': imageName,
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
      imageName: $imageName,
      roomId: $roomId,
      roomPassword: $roomPassword
    }''';
  }
}
