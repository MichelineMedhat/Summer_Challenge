import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/challenge.dart';

abstract class ChallengeState extends Equatable {
  const ChallengeState();

  @override
  List<Object> get props => [];
}

class AllChallengesLoading extends ChallengeState {
  @override
  String toString() => 'AllchallengesLoading';
}

class AllchallengesLoaded extends ChallengeState {
  final List<Challenge> challenges;

  const AllchallengesLoaded({@required this.challenges});

  @override
  List<Object> get props => [challenges];

  @override
  String toString() => 'AllchallengesLoaded { challenges: $challenges }';
}
