import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:summer_challenge/models/user.dart';

abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

class ScoresLoadInProgress extends ScoreState {
  @override
  String toString() => 'ScoresLoadInProgress';
}

class ScoresLoadSuccess extends ScoreState {
  final List<User> users;
  final bool usersEnd;

  const ScoresLoadSuccess({@required this.users, @required this.usersEnd});

  @override
  List<Object> get props => [users, usersEnd];

  @override
  String toString() => 'ScoresLoadSuccess { users: $users, usersEnd: $usersEnd }';
}

class ScoresLoadFailure extends ScoreState {
  final String message;

  ScoresLoadFailure(this.message);

  @override
  String toString() {
    return 'ScoresLoadFailure{message: $message}';
  }
}
