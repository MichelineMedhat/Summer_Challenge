import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.person), onPressed: (){},),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Welcome ${user.name}!')),
        ],
      ),
    );
  }
}
