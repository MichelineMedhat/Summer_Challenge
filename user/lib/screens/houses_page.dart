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
      zoomLink: 'ana zoom link',
      playlistUri:
          'PLiWY5uwrAVPuUipwXGjBXIghPJm4YoQCR',
    ));
    houses.add(House(
      houseName: 'illustrator_house',
      imageName: 'illustrator.jpg',
      releaseDate: 'Tuesday',
      zoomDate: 'Sunday',
      zoomLink: 'ana zoom link',
      playlistUri:
          "PLiWY5uwrAVPtrNYnLH20eJymVbloRLchi",
    ));
    houses.add(House(
      houseName: 'coding_house',
      imageName: 'coding.jpg',
      releaseDate: 'Tuesday',
      zoomDate: 'Sunday',
      zoomLink: 'ana zoom link',
      playlistUri: 'PLiWY5uwrAVPtj6Y82sZmi18hIH2FpwAR6',
    ));
    houses.add(House(
      houseName: 'photographing_house',
      imageName: 'photographing.jpeg',
      releaseDate: 'Tuesday',
      zoomDate: 'Sunday',
      zoomLink: 'ana zoom link',
    ));
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 576
              ? MediaQuery.of(context).size.width / 4
              : MediaQuery.of(context).size.width / 8,
          vertical: 16),
      child: GridView.count(
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
            ),
          )),
    );
  }
}
