import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sing_in_bloc/bloc.dart';
import '../repositories/user_repository.dart';
import '../screens/sign_up_screen.dart';
import '../widgets/rounded_button.dart';
import '../widgets/outlined_text_field.dart';

class SignInScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SignInScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: _userRepository),
        child: SignInForm(userRepository: _userRepository),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignInForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<SignInForm> createState() => _SignInState();
}

class _SignInState extends State<SignInForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  SignInBloc _signInBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isSignInButtonEnabled(SignInState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Container(
                width: 700,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(32.0),
                  child: Align(
                    alignment:Alignment.centerRight,
                    child: Column(         
                      children: <Widget>[
                        CircleAvatar(
                          child: Image.asset('assets/logo.png'),
                          backgroundColor: Colors.transparent,
                          radius: 100,
                        ),
                        SizedBox(height: 48.0),
                        OutlinedTextField(
                          textKey: 'Username',
                          controller: _usernameController,
                          validator: (_) {
                            return !state.isUsernameValid
                                ? 'Invalid Username'
                                : null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        OutlinedTextField(
                          textKey: 'Password',
                          obscureText: true,
                          controller: _passwordController,
                          validator: (_) {
                            return !state.isPasswordValid
                                ? 'Invalid Password'
                                : null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        RoundedButton(
                          textKey: 'Sign in',
                          onPressed: isSignInButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                        ),
                        SizedBox(height: 18.0),
                        InkWell(
                          child: new Text('Create an account!!', style: TextStyle(color: Colors.red)),
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                           onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(
                                userRepository: _userRepository,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _signInBloc.add(
      UsernameChanged(username: _usernameController.text),
    );
  }

  void _onPasswordChanged() {
    _signInBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _signInBloc.add(
      SignInWithCredentialsPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }
}
