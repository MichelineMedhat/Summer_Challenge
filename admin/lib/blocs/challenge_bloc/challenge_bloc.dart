import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../repositories/challenge_repository.dart';
import '../../models/challenge.dart';
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
    } else if (event is AddChallenge) {
      yield* _mapAddChallengeToState(event.challenge);
    } else if (event is DeleteChallenge) {
      yield* _mapDeleteChallengeToState(event.challengeId);
    }
  }

  Stream<ChallengeState> _mapLoadChallengesToState() async* {
    _postSubscription?.cancel();
    _postSubscription = ChallengeRepository.getAllChallenges()
        .listen((challenge) => add(Updatechallenges(challenges: challenge)));
  }

  Stream<ChallengeState> _mapAddChallengeToState(Challenge challenge) async* {
    try {
      await ChallengeRepository.addChallenge(challenge);
      add(Loadchallenges());
    } catch (err) {
      yield ChallengeAddFailure();
      print('error adding challenge');
    }
  }

    Stream<ChallengeState> _mapDeleteChallengeToState(String challengeId) async* {
    try {
      await ChallengeRepository.deleteChallenge(challengeId);
      add(Loadchallenges());
    } catch (err) {
      yield ChallengeAddFailure();
      print('error deletion challenge');
    }
  }

}
