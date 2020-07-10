import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    BlocProvider.of<ScoreBloc>(context).add(LoadScores(cachedUsers: []));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.width > 576
                      ? MediaQuery.of(context).size.width / 96
                      : MediaQuery.of(context).size.width / 20),
              Text(
                'Score Board',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Container(
                        width: MediaQuery.of(context).size.width > 576
                            ? MediaQuery.of(context).size.width / 4
                            : MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            padding: EdgeInsets.all(16),
                            scrollDirection: Axis.vertical,
                            itemCount: state.users.length,
                            controller: scrollController,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ListTile(
                                    leading: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    title: Text(
                                      state.users[index].username,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      "Score: ${state.users[index].score}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: FaIcon(FontAwesomeIcons.trophy,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                            }),
                      ),
                        SizedBox(
                                    height: MediaQuery.of(context).size.width >
                                            576
                                        ? MediaQuery.of(context).size.width / 96
                                        : MediaQuery.of(context).size.width /
                                            20),
                                state.usersEnd
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            Icon(Icons.error_outline,
                                                color: Colors.orange),
                                            SizedBox(width: 4),
                                            Text(
                                              "No more Scores!",
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ])
                                    : FlatButton.icon(
                                        onPressed: () {
                                          BlocProvider.of<ScoreBloc>(context)
                                              .add(LoadScores(
                                                  cachedUsers: state.users));
                                        },
                                        icon: Icon(Icons.refresh,
                                            color: Colors.orange),
                                        label: Text(
                                          "See More",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        )),
                                SizedBox(
                                    height: MediaQuery.of(context).size.width >
                                            576
                                        ? MediaQuery.of(context).size.width / 88
                                        : MediaQuery.of(context).size.width /
                                            10),
                    ]);
                  } else {
                    return Text((state as ScoresLoadFailure).message);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}
