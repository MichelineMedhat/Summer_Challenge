import 'package:flutter/material.dart';
import 'package:summer_challenge/models/challenge.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;

  const ChallengeCard({Key key, this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.2, 2.4),
            color: Colors.orange,
            blurRadius: .64,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            challenge.title,
            style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.start,
          ),
          Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            challenge.body,
            style: TextStyle(color:Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
           Divider(
            color: Colors.grey,
            thickness: 0.2,
          ),
          challenge.hashtag.isNotEmpty
              ? Container(
                  child: Text(
                    '#${challenge.hashtag}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
