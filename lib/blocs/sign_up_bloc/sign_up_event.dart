import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends SignUpEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name: $name }';
}

class UsernameChanged extends SignUpEvent {
  final String username;

  const UsernameChanged({@required this.username});

  @override
  List<Object> get props => [username];

  @override
  String toString() => 'UsernameChanged { username :$username }';
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

  const Submitted({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Submitted { user: $user }';
}

