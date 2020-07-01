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
            color: Colors.black12,
            blurRadius: .64,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            challenge.title,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            challenge.body,
          ),
          SizedBox(
            height: 20,
          ),
          challenge.hashtag.isNotEmpty
              ? Container(
                  child: Text(
                    '#${challenge.hashtag}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
