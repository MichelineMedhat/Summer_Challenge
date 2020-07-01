import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_challenge/blocs/challenge_bloc/bloc.dart';
import 'package:summer_challenge/widgets/challenge_card.dart';

class ChallengesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChallengeBloc>(context).add(Loadchallenges());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Challenges", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Container(
              width: 400,
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
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ChallengeCard(
                              challenge: state.challenges[index]);
                        });
                  } else {
                    return Text('Please Check your internet Connection');
                  }
                },
              )),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
