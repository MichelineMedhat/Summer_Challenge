import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker_web/image_picker_web.dart';

import '../blocs/authentication_bloc/bloc.dart';
import '../blocs/sign_up_bloc/bloc.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../widgets/rounded_button.dart';
import '../widgets/outlined_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final UserRepository _userRepository;

  SignUpScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(userRepository: _userRepository),
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _secretKeyController = TextEditingController();

  SignUpBloc _signUpBloc;
  Image pickedImage;

  bool get isPopulated =>
      _phoneNumberController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _secretKeyController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _phoneNumberController.addListener(_onPhoneNumberChanged);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
    _secretKeyController.addListener(_onSecretKeyChanged);
    pickedImage = Image.asset('assets/pp.png');
  }

  String extenstion;
  bool isImagePicked = false;
  Uint8List data;
  pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    extenstion = Path.extension(mediaData.fileName);
    if (mediaData != null) {
      setState(() {
        data = mediaData.data;
        pickedImage = Image.memory(data);
        isImagePicked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black87,
            body: Center(
              child: Container(
                width: 700,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(32.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              switchInCurve: Curves.easeIn,
                              child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 100,
                                    child: ClipOval(
                                      child: pickedImage,
                                    ),
                                  ) ??
                                  Container(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                onPressed: () => pickImage(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48.0),
                        OutlinedTextField(
                          textKey: 'PhoneNumber',
                          controller: _phoneNumberController,
                          validator: (_) {
                            return !state.isPhoneNumberValid ? 'Required*' : null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        OutlinedTextField(
                          textKey: 'Username',
                          controller: _usernameController,
                          validator: (_) {
                            return !state.isUsernameValid
                                ? 'Username Already Exists, ex:MichelineMedhat'
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
                                ? 'More Than 8 7erooof wi waaa'
                                : null;
                          },
                        ),
                        SizedBox(height: 24.0),
                        OutlinedTextField(
                          textKey: 'Secret Key',
                          obscureText: true,
                          controller: _secretKeyController,
                          validator: (_) {
                            return !state.isSecretKeyValid
                                ? 'Ask el 5adema 3aleh :) See you Soon ♥'
                                : null;
                          },
                        ),
                         SizedBox(height: 32.0),
                        RoundedButton(
                          textKey: 'Sign up',
                          onPressed: isSignUpButtonEnabled(state)
                              ? _onFormSubmitted
                              : null,
                        ),
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
    _phoneNumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onPhoneNumberChanged() {
    _signUpBloc.add(
      PhoneNumberChanged(phoneNumber: _phoneNumberController.text),
    );
  }

  void _onSecretKeyChanged() {
    _signUpBloc.add(
      SecretKeyChanged(secretKey: _secretKeyController.text),
    );
  }

  void _onUsernameChanged() {
    _signUpBloc.add(
      UsernameChanged(username: _usernameController.text.toLowerCase()),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  Future<void> _onFormSubmitted() async {
    User user = User(
      phoneNumber: _phoneNumberController.text,
      username: _usernameController.text.toLowerCase(),
      password: _passwordController.text,
    );

    _signUpBloc
        .add(Submitted(user: user, imageData: data, extenstion: extenstion));
  }
}
