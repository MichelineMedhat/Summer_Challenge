import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:summer_challenge/widgets/house_card.dart';

class HousesPage extends StatelessWidget {
  final User user;
  final List<House> houses = [];

  HousesPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    houses.clear();
    houses.add(
      House(
        houseName: 'photoshop_house',
        imageName: 'photoshop.jpg',
        releaseDate: 'Tuesday',
        zoomDate: 'Sunday',
        zoomLink: 'ana zoom link',
      )
    );
    houses.add(
      House(
        houseName: 'illustrator_house',
        imageName: 'illustrator.jpg',
        releaseDate: 'Tuesday',
        zoomDate: 'Sunday',
        zoomLink: 'ana zoom link',
      )
    );
    houses.add(
      House(
        houseName: 'conding_house',
        imageName: 'coding.jpg',
        releaseDate: 'Tuesday',
        zoomDate: 'Sunday',
        zoomLink: 'ana zoom link',
      )
    );
    houses.add(
      House(
        houseName: 'photographing_house',
        imageName: 'photographing.jpeg',
        releaseDate: 'Tuesday',
        zoomDate: 'Sunday',
        zoomLink: 'ana zoom link',
      )
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3.5, vertical: 16),
        child: ListView.builder(
            itemCount: houses.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return House(
                  houseName: this.houses[index].houseName,
                  imageName: this.houses[index].imageName,
                  releaseDate: this.houses[index].releaseDate,
                  zoomDate: this.houses[index].zoomDate,
                  zoomLink: this.houses[index].zoomLink);
            }),
      ),
    );
  }
}
