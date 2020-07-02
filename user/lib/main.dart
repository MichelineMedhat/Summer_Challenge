import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_challenge/blocs/challenge_bloc/bloc.dart';
import 'package:summer_challenge/blocs/score_bloc/bloc.dart';

import 'blocs/authentication_bloc/bloc.dart';
import 'blocs/post_bloc/post_bloc.dart';
import 'repositories/user_repository.dart';
import 'screens/home_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //BlocSupervisor.delegate = AppBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    ),
    BlocProvider<PostBloc>(
      create: (BuildContext context) => PostBloc(),
    ),
    BlocProvider<ScoreBloc>(
      create: (BuildContext context) => ScoreBloc(),
    ),
    BlocProvider<ChallengeBloc>(
      create: (BuildContext context) => ChallengeBloc(),
    )
  ], child: App(userRepository: userRepository)));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({
    Key key,
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        errorColor: Colors.orange,
        cardColor: Color(0xff2B2A28),
        backgroundColor: Colors.black87
      ),
      title: 'Summer Challenge',
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return SignInScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(user: state.user);
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}
