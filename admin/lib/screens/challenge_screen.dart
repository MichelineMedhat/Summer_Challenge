import 'package:admin/blocs/challenge_bloc/bloc.dart';
import 'package:admin/models/challenge.dart';
import 'package:admin/widgets/challenge_card.dart';
import 'package:admin/widgets/challenge_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  ChallengeBloc challengeBloc;

  @override
  void initState() {
    super.initState();
    challengeBloc = BlocProvider.of<ChallengeBloc>(context)
      ..add(Loadchallenges());
    ChallengeDialog.titleEditingController = TextEditingController();
    ChallengeDialog.bodyEditingController = TextEditingController();
    ChallengeDialog.hashtagEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Text(
              'Challenges',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              width: 512,
              child: BlocBuilder<ChallengeBloc, ChallengeState>(
                builder: (context, state) {
                  if (state is AllChallengesLoading) {
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        ),
                      ),
                    );
                  } else if (state is AllchallengesLoaded) {
                    return ListView.builder(
                        itemCount: state.challenges.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ChallengeCard(
                            challenge: state.challenges[index],
                          );
                        });
                  } else {
                    return Text("Error");
                  }
                },
              ),
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 28,
        ),
        onPressed: _showMyDialog,
      ),
    );
  }

  Future<void> _showMyDialog() {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return ChallengeDialog(
            onPressed: () {
              Challenge challenge = Challenge(
                  title: ChallengeDialog.titleEditingController.text,
                  body: ChallengeDialog.bodyEditingController.text,
                  hashtag: ChallengeDialog.hashtagEditingController.text,
                  timestamp: Timestamp.now());

              challengeBloc.add(AddChallenge(challenge: challenge));
              Navigator.of(context).pop();
            },
          );
        });
  }
}
