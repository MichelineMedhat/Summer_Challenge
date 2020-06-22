import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/app_bloc_delegate.dart';
import 'blocs/authentication_bloc/bloc.dart';
import 'repositories/user_repository.dart';
import 'screens/home_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/splash_screen.dart';



void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //BlocSupervisor.delegate = AppBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      child: App(userRepository: userRepository),
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    ),
  );
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
