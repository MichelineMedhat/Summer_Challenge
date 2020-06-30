import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class House extends StatelessWidget {
  final String houseName;
  final String zoomLink;
  final String zoomDate;
  final String releaseDate;
  final String imageName;

  House(
      {this.houseName,
      this.zoomLink,
      this.zoomDate,
      this.imageName,
      this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0.5),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  'assets/$imageName',
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 6,
                )),
            Text(
              '#${this.houseName}',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.width / 75),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Zoom Link: ',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 75)),
                InkWell(
                    child: new Text(
                      '$zoomLink',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width / 75),
                    ),
                    onTap: () => launch('$zoomLink')),
              ],
            ),
            Text('Zoom Date: $zoomDate',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 75)),
            SizedBox(
              width: MediaQuery.of(context).size.width / 14,
              height: MediaQuery.of(context).size.width / 40,
              child: OutlineButton(
                child: new Text('${this.releaseDate}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width / 120)),
                onPressed: null,
                disabledBorderColor: Colors.blue,
                shape: StadiumBorder(),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
