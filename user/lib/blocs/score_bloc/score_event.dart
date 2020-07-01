import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:summer_challenge/models/user.dart';

abstract class ScoreEvent extends Equatable {
  const ScoreEvent();

  @override
  List<Object> get props => [];
}

class LoadScores extends ScoreEvent {
  @override
  String toString() {
    return 'Loadchallenges';
  }
}

class UpdateScores extends ScoreEvent {
  final List<User> users;

  const UpdateScores({@required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'UpdateScores { users: $users }';
}
