import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_challenge/blocs/score_bloc/bloc.dart';

class ScoresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScorePageState();
}

class _ScorePageState extends State<StatefulWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScoreBloc>(context).add(LoadScores());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.width > 576
                  ? MediaQuery.of(context).size.width / 96
                  : MediaQuery.of(context).size.width / 20),
          BlocBuilder<ScoreBloc, ScoreState>(
            builder: (context, state) {
              if (state is ScoresLoadInProgress) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                );
              } else if (state is ScoresLoadSuccess) {
                return Container(
                  width: MediaQuery.of(context).size.width > 576
                      ? MediaQuery.of(context).size.width / 2
                      : MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      scrollDirection: Axis.vertical,
                      itemCount: state.users.length,
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(
                            "${index + 1}",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          title: Text(state.users[index].username),
                          subtitle: Text("Score: ${state.users[index].score}"),
                        );
                      }),
                );
              } else {
                return Text((state as ScoresLoadFailure).message);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
