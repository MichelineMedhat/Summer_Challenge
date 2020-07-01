import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/challenge_repository.dart';
import 'bloc.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  StreamSubscription _postSubscription;

  @override
  ChallengeState get initialState => AllChallengesLoading();

  @override
  Stream<ChallengeState> mapEventToState(ChallengeEvent event) async* {
    if (event is Loadchallenges) {
      yield* _mapLoadChallengesToState();
    } else if (event is Updatechallenges) {
      yield AllchallengesLoaded(challenges: event.challenges);
    }
  }

  Stream<ChallengeState> _mapLoadChallengesToState() async* {
    yield AllChallengesLoading();
    _postSubscription?.cancel();
    _postSubscription = ChallengeRepository.getAllChallenges()
        .listen((challenge) => add(Updatechallenges(challenges: challenge)));
  }
}
