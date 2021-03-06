import 'package:admin/blocs/challenge_bloc/bloc.dart';
import 'package:admin/blocs/house_bloc/bloc.dart';
import 'package:admin/blocs/post_bloc/post_bloc.dart';
import 'package:admin/blocs/user_bloc/bloc.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<PostBloc>(
      create: (BuildContext context) => PostBloc(),
    ),
    BlocProvider<ChallengeBloc>(
      create: (BuildContext context) => ChallengeBloc(),
    ),
    BlocProvider<HouseBloc>(
      create: (BuildContext context) => HouseBloc(),
    ),
    BlocProvider<UserBloc>(
      create: (BuildContext context) => UserBloc(),
    )
  ], child: App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Admin', debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
