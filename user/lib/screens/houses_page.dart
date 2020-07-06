import 'package:flutter/material.dart';
import 'package:summer_challenge/widgets/house_card.dart';

import '../models/user.dart';
import '../models/house.dart';



class HousesPage extends StatelessWidget {
  final User user;
  final List<House> houses = [];

  HousesPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    houses.clear();
    houses.add(House(
      houseName: 'photoshop_house',
      imageName: 'photoshop.jpg',
      releaseDate: 'Friday',
      zoomDate: 'Saturday 8:00pm',
      playlistUri: 'PLKXBMPaBJi02o9Biq6M19nEMkEdTdDx8b',
      zoomLink:
          ' https://us04web.zoom.us/j/7676067674?pwd=QUNRb2tIV0xWQ0lEMVIrVy81c09XZz09',
      roomId: '7676067674',
      roomPassword: '940103',
    ));
    houses.add(House(
      houseName: 'illustrator_house',
      imageName: 'illustrator.jpg',
      releaseDate: 'Thursday',
      zoomDate: 'Friday 7:00pm',
      playlistUri: "PLKXBMPaBJi03JuErra0R3mVtbW20KaOh0",
      zoomLink:
          'https://us04web.zoom.us/j/2132008045?pwd=Y0MvQllTa0krNjBpUXpha3Z1OSs3UT09',
      roomId: '2132008045',
      roomPassword: '2kPpdZ',
    ));
    houses.add(House(
      houseName: 'coding_house',
      imageName: 'coding.jpg',
      releaseDate: 'Thursday',
      zoomDate: 'Monday 9:00pm',
      zoomLink:
          'https://us04web.zoom.us/j/8171925844?pwd=NlB5ZUI1Qk9JLzlLRk1DQk1mUDFXdz09',
      playlistUri: 'PLKXBMPaBJi00VxmTfvU_mtu4PdMYcwQ1p',
      roomId: '8171925844',
      roomPassword: '032741',
    ));
    houses.add(House(
      houseName: 'photographing_house',
      imageName: 'photographing.jpeg',
      releaseDate: 'No Youtube',
      zoomDate: 'Tuesday 9:00pm',
      zoomLink:
          'https://us04web.zoom.us/j/8171925844?pwd=NlB5ZUI1Qk9JLzlLRk1DQk1mUDFXdz09',
      roomId: '8171925844',
      roomPassword: '032741',
    ));
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width > 576
                ? MediaQuery.of(context).size.width / 4
                : MediaQuery.of(context).size.width / 8,
            vertical: 16),
        child: GridView.count(
          childAspectRatio: MediaQuery.of(context).size.width > 567 ? 0.9 : 0.8,
          crossAxisCount: MediaQuery.of(context).size.width > 576 ? 2 : 1,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: List<Widget>.generate(
            houses.length,
            (int index) => HouseCard(house: houses[index]),
          ),
        ),
      ),
    );
  }
}
