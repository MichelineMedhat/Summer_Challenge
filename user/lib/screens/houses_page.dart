import 'package:flutter/material.dart';
import 'package:summer_challenge/widgets/house_card.dart';

import '../models/user.dart';

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
      releaseDate: 'Tuesday',
      zoomDate: 'Sunday',
      playlistUri: 'PLiWY5uwrAVPuUipwXGjBXIghPJm4YoQCR',
      zoomLink:
          'https://us04web.zoom.us/j/8171925844?pwd=NlB5ZUI1Qk9JLzlLRk1DQk1mUDFXdz09',
      roomId: '8171925844',
      roomPassword: '032741',
    ));
    houses.add(House(
      houseName: 'illustrator_house',
      imageName: 'illustrator.jpg',
      releaseDate: 'Thursday',
      zoomDate: 'Friday 7:00pm',
      playlistUri: "PLiWY5uwrAVPtrNYnLH20eJymVbloRLchi",
      zoomLink:'https://us04web.zoom.us/j/2132008045?pwd=Y0MvQllTa0krNjBpUXpha3Z1OSs3UT09',
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
      playlistUri: 'PLiWY5uwrAVPtj6Y82sZmi18hIH2FpwAR6',
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
          childAspectRatio:MediaQuery.of(context).size.width > 567?0.9 : 0.8,
            crossAxisCount: MediaQuery.of(context).size.width > 576 ? 2 : 1,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: List<Widget>.generate(
              houses.length,
              (int index) => House(
                houseName: houses[index].houseName,
                imageName: houses[index].imageName,
                releaseDate: houses[index].releaseDate,
                zoomDate: houses[index].zoomDate,
                zoomLink: houses[index].zoomLink,
                playlistUri: houses[index].playlistUri,
                roomId: houses[index].roomId,
                roomPassword: houses[index].roomPassword,
              ),
            )),
      ),
    );
  }
}
