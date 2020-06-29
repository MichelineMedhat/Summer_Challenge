import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:summer_challenge/widgets/house_card.dart';

class HousesPage extends StatelessWidget {
  final User user;

  HousesPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  House(
                    houseName: 'photoshop_house',
                    imageName: 'photoshop.jpg',
                    releaseDate: 'Tuesday',
                    zoomDate: 'Sunday',
                    zoomLink: 'ana zoom link',
                  ),
                  House(
                    houseName: 'illustrator_house',
                    imageName: 'illustrator.jpg',
                    releaseDate: 'Tuesday',
                    zoomDate: 'Sunday',
                    zoomLink: 'ana zoom link',
                  )
                ],
              ),
              Column(
                children: [
                  House(
                    houseName: 'conding_house',
                    imageName: 'coding.jpg',
                    releaseDate: 'Tuesday',
                    zoomDate: 'Sunday',
                    zoomLink: 'ana zoom link',
                  ),
                  House(
                    houseName: 'photographing_house',
                    imageName: 'photographing.jpeg',
                    releaseDate: 'Tuesday',
                    zoomDate: 'Sunday',
                    zoomLink: 'ana zoom link',
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
