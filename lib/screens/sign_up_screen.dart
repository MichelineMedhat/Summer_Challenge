import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:firebase/firebase.dart' as fb;


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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignUpBloc _signUpBloc;
  Image pickedImage;

  bool get isPopulated =>
      _nameController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
    _nameController.addListener(_onNameChanged);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
    pickedImage = Image.asset('assets/logo.png');
  }

  pickImage() async {
    Image fromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.widget);
    if (fromPicker != null) {
      setState(() {
        pickedImage = fromPicker;
      });
    }
  }

  Future<Uri> uploadImageFile(Image image,
      {String imageName}) async {
    fb.StorageReference storageRef = fb.storage().ref('images/$imageName');
    fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(image).future;
    
    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
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
                              duration: Duration(milliseconds: 300),
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
                                  size: 30.0,
                                ),
                                onPressed: () => pickImage(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48.0),
                        OutlinedTextField(
                          textKey: 'Name',
                          controller: _nameController,
                        ),
                        SizedBox(height: 32.0),
                        OutlinedTextField(
                          textKey: 'Username',
                          controller: _usernameController,
                          validator: (_) {
                            return !state.isUsernameValid
                                ? 'Invalid Username'
                                : null;
                          },
                        ),
                        SizedBox(height: 32.0),
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
                        SizedBox(height: 48.0),
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
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    _signUpBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onUsernameChanged() {
    _signUpBloc.add(
      UsernameChanged(username: _usernameController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    
    uploadImageFile(pickedImage);
    User user = User(
      name: _nameController.text,
      username: _usernameController.text,
      password: _passwordController.text,
    );
    
    _signUpBloc.add(Submitted(user: user));
  }
}
