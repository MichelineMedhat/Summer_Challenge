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
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Challenges",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
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
                        if (state.challenges.isEmpty) {
                          return Center(
                              child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.asset(
                                  "assets/face-shield-girl.png",
                                  width: MediaQuery.of(context).size.width > 576
                                      ? MediaQuery.of(context).size.width / 10
                                      : MediaQuery.of(context).size.width / 6,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: Text(
                                  "No Challenges yet!",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ],
                          ));
                        } else {
                          return ListView.builder(
                              itemCount: state.challenges.length,
                              scrollDirection: Axis.vertical,
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ChallengeCard(
                                    challenge: state.challenges[index]);
                              });
                        }
                      } else {
                        return Text('Please Check your internet Connection');
                      }
                    },
                  )),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
