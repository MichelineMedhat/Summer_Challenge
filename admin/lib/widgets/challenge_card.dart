import 'package:admin/blocs/challenge_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/challenge.dart';

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  const ChallengeCard({Key key, this.challenge})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
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
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 16),
          Text(
            challenge.body,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 16),
          Text(
            '#${challenge.hashtag}',
          ),
          SizedBox(height: 16),
          FloatingActionButton(
              onPressed: () {
                BlocProvider.of<ChallengeBloc>(context)
                    .add(DeleteChallenge(challengeId: challenge.id));
              },
              child: Icon(Icons.delete))
        ],
      ),
    );
  }
}
