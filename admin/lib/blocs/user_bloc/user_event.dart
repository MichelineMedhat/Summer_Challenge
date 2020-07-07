import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {
  final String keyword;

  LoadUsers(this.keyword);

  @override
  String toString() {
    return 'LoadUsers{keyword: $keyword}';
  }
}

class UpdateUsers extends UserEvent {
  final List<User> users;

  const UpdateUsers({@required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'UpdateUsers { users: $users }';
}

class DeleteUser extends UserEvent {
  final User user;

  const DeleteUser({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'DeleteUser { user: $user }';
}
