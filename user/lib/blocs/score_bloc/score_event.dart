import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:summer_challenge/models/user.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class LoadScores extends ScoreEvent {
  final List<User> cachedUsers;

  LoadScores({@required this.cachedUsers});

  @override
  List<Object> get props => [cachedUsers];
  @override
  String toString() {
    return 'Loadchallenges { cachedUsers: $cachedUsers }';
  }
}

class UpdateScores extends ScoreEvent {
  final List<User> users;
  final bool usersEnd;

  const UpdateScores({@required this.users, this.usersEnd = true});

  @override
  List<Object> get props => [users, usersEnd];

  @override
  String toString() => 'UpdateScores { users: $users, usersEnd: $usersEnd }';
}
