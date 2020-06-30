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
      hoverColor: Colors.transparent,
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
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/$imageName',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width > 576
                  ? MediaQuery.of(context).size.width / 96
                  : MediaQuery.of(context).size.width / 20),
          Text(
            '#${this.houseName}',
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
                    '$zoomLink',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width > 576
                            ? MediaQuery.of(context).size.width / 96
                            : MediaQuery.of(context).size.width / 24),
                  ),
                  onTap: () => launch('$zoomLink')),
            ],
          ),
          Text('Zoom Date: $zoomDate',
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
                : MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.width > 576
                ? MediaQuery.of(context).size.width / 40
                : MediaQuery.of(context).size.width / 16,
            child: OutlineButton(
              child: new Text('${this.releaseDate}',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: MediaQuery.of(context).size.width > 576
                          ? MediaQuery.of(context).size.width / 120
                          : MediaQuery.of(context).size.width / 40)),
              onPressed: null,
              disabledBorderColor: Colors.blue,
              shape: StadiumBorder(),
            ),
          )
        ]),
      ),
    );
  }
}
