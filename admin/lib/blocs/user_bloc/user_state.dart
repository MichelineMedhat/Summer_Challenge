import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UsersLoadInProgress extends UserState {
  @override
  String toString() => 'UsersLoadInProgress';
}

class UsersLoadSuccess extends UserState {
  final List<User> users;

  const UsersLoadSuccess({@required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'UsersLoadSuccess { users: $users }';
}

class UsersLoadFailure extends UserState {
  final String message;

  UsersLoadFailure(this.message);

  @override
  String toString() {
    return 'UsersLoadFailure {message: $message}';
  }
}
