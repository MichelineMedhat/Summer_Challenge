import 'package:admin/blocs/house_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/house.dart';
import 'package:url_launcher/url_launcher.dart';

class HouseCard extends StatelessWidget {
  final House house;

  const HouseCard({Key key, this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () => house.playlistUri != null
          ? launch('https://www.youtube.com/playlist?list=${house.playlistUri}')
          : null,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0.5),
          ],
        ),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              house.imageUri,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width > 576
                  ? MediaQuery.of(context).size.width / 96
                  : MediaQuery.of(context).size.width / 20),
          Text(
            '#${house.houseName}',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.width > 576
                    ? MediaQuery.of(context).size.width / 75
                    : MediaQuery.of(context).size.width / 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Zoom Link: ',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 576
                          ? MediaQuery.of(context).size.width / 96
                          : MediaQuery.of(context).size.width / 24)),
              InkWell(
                  child: new Text(
                    'Press me',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width > 576
                            ? MediaQuery.of(context).size.width / 96
                            : MediaQuery.of(context).size.width / 24),
                  ),
                  onTap: () => launch('${house.zoomLink}')),
            ],
          ),
          Text('Zoom Date: ${this.house.zoomDate}',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 576
                      ? MediaQuery.of(context).size.width / 75
                      : MediaQuery.of(context).size.width / 20)),
          Text('Room ID: ${house.roomId}',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 576
                      ? MediaQuery.of(context).size.width / 75
                      : MediaQuery.of(context).size.width / 20)),
          Text('Room Password: ${house.roomPassword}',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 576
                      ? MediaQuery.of(context).size.width / 75
                      : MediaQuery.of(context).size.width / 20)),
          SizedBox(
              height: MediaQuery.of(context).size.width > 576
                  ? MediaQuery.of(context).size.width / 96
                  : MediaQuery.of(context).size.width / 32),
          SizedBox(
            width: MediaQuery.of(context).size.width > 576
                ? MediaQuery.of(context).size.width / 14
                : MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width > 576
                ? MediaQuery.of(context).size.width / 40
                : MediaQuery.of(context).size.width / 16,
            child: OutlineButton(
              child: new Text('${this.house.releaseDate}',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: MediaQuery.of(context).size.width > 576
                          ? MediaQuery.of(context).size.width / 120
                          : MediaQuery.of(context).size.width / 40)),
              onPressed: null,
              disabledBorderColor: Colors.blue,
              shape: StadiumBorder(),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width > 576
                  ? MediaQuery.of(context).size.width / 96
                  : MediaQuery.of(context).size.width / 32),
          FlatButton.icon(
              onPressed: () => BlocProvider.of<HouseBloc>(context)
                  .add(DeleteHouse(house: house)),
              icon: Icon(Icons.delete),
              label: Text('Delete'))
        ]),
      ),
    );
  }
}
