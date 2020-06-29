import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends SignUpEvent {
  final String phoneNumber;

  const PhoneNumberChanged({@required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() => 'PhoneNumberChanged { phoneNumber: $phoneNumber }';
}

class UsernameChanged extends SignUpEvent {
  final String username;

  const UsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username :$username }';
}


class SecretKeyChanged extends SignUpEvent {
  final String secretKey;

  const SecretKeyChanged({@required this.secretKey});

  @override
  List<Object> get props => [SecretKeyChanged];

  @override
  String toString() => 'SecretKeyChanged { SecretKeyChanged :$SecretKeyChanged }';
}

class UsernameSubmitted extends SignUpEvent {
  final String username;

  const UsernameSubmitted({@required this.username});

  @override
  String toString() {
    return 'UsernameSubmitted { username: $username }';
  }
}

class PasswordChanged extends SignUpEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends SignUpEvent {
  final User user;
  final Uint8List imageData;
  final String extenstion;

  const Submitted(
      {@required this.user,
      @required this.imageData,
      @required this.extenstion});

  @override
  List<Object> get props => [user, imageData, extenstion];

  @override
  String toString() =>
      'Submitted { user: $user, imageData: $imageData, extenstion:$extenstion}';
}
