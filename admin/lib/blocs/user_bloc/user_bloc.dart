import 'dart:async';

import 'package:admin/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';

import '../../models/user.dart';
import 'bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  StreamSubscription _usersSubscription;

  @override
  UserState get initialState => UsersLoadInProgress();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUsers) {
      yield* _mapLoadUsersToState(event.keyword);
    } else if (event is UpdateUsers) {
      yield UsersLoadSuccess(users: event.users);
    } else if (event is DeleteUser) {
      yield* _mapDeleteUserToState(event.user);
    }
  }

  Stream<UserState> _mapLoadUsersToState(String keyword) async* {
    yield UsersLoadInProgress();
    if (keyword.toLowerCase() == "all") {
      _usersSubscription?.cancel();
      _usersSubscription = UserRepository.getUsers()
          .listen((users) => add(UpdateUsers(users: users)));
    } else if (keyword.toLowerCase().isNotEmpty) {
      _usersSubscription?.cancel();
      _usersSubscription = UserRepository.getUser(keyword)
          .listen((user) => add(UpdateUsers(users: user)));
    }
  }

  Stream<UserState> _mapDeleteUserToState(User user) async* {
    yield UsersLoadInProgress();
    await UserRepository.deleteUser(user);
    yield* _mapLoadUsersToState("");
  }
}
