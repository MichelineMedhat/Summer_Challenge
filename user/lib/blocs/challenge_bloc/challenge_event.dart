import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/challenge.dart';

abstract class ChallengeEvent extends Equatable {
  const ChallengeEvent();
  @override
  List<Object> get props => [];
}

class Loadchallenges extends ChallengeEvent {
  @override
  String toString() {
    return 'Loadchallenges';
  }
}

class Updatechallenges extends ChallengeEvent {
  final List<Challenge> challenges;

  const Updatechallenges({@required this.challenges});

  @override
  List<Object> get props => [challenges];

  @override
  String toString() => 'Updatechallenges { challenges: $challenges }';
}
