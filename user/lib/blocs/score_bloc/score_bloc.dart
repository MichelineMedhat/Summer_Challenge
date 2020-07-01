import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:summer_challenge/repositories/user_repository.dart';

import 'bloc.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  StreamSubscription _postSubscription;

  @override
  ScoreState get initialState => ScoresLoadInProgress();

  @override
  Stream<ScoreState> mapEventToState(ScoreEvent event) async* {
    if(event is LoadScores) {
      yield* _mapLoadChallengesToState();
    }else if (event is UpdateScores){
      yield ScoresLoadSuccess(users: event.users);
    }
    }

  Stream<ScoreState> _mapLoadChallengesToState() async* {
    yield ScoresLoadInProgress();
    _postSubscription?.cancel();
    _postSubscription = UserRepository.getScores()
        .listen((users) => add(UpdateScores(users: users)));
  }
}
