import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/authentication_bloc/bloc.dart';
import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  ProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('It\'s profile')),
        ],
      ),
    );
  }
}
