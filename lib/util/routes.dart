import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:summer_challenge/screens/sign_in_screen.dart';

import '../screens/home_screen.dart';
import '../screens/sign_in_screen.dart';
import '../screens/sign_up_screen.dart';

class FluroRouter {
  static Router router = Router();
  static Handler _signInHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignInScreen(userRepository: params['username'][0],));
  static Handler _signUpHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignUpScreen(userRepository: params['username'][0],));
  static Handler _homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomeScreen(user: params['username'][0]));
  static void setupRouter() {
    router.define(
      'signin',
      handler: _signInHandler,
    );
     router.define(
      'signup',
      handler: _signUpHandler,
    );
    router.define(
      'home',
      handler: _homeHandler,
    );
  }
}