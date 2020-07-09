import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/user.dart';
import '../../repositories/user_repository.dart';

import 'bloc.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  StreamSubscription _postSubscription;

  @override
  ScoreState get initialState => ScoresLoadInProgress();

  @override
  Stream<ScoreState> mapEventToState(ScoreEvent event) async* {
    if (event is LoadScores) {
      yield* _mapLoadChallengesToState(event.cachedUsers);
    } else if (event is UpdateScores) {
      yield ScoresLoadSuccess(users: event.users, usersEnd: event.usersEnd);
    }
  }

  Stream<ScoreState> _mapLoadChallengesToState(List<User> cachedUsers) async* {
    yield ScoresLoadInProgress();
    if (cachedUsers.isEmpty) {
      UserRepository.disposePagination();
    }
    _postSubscription?.cancel();
    _postSubscription = UserRepository.getScores().listen((fetchedUsers)  {
      print(fetchedUsers);
      add(

        UpdateScores(
            users: cachedUsers + fetchedUsers,
            usersEnd: fetchedUsers.isEmpty));});
  }
}
