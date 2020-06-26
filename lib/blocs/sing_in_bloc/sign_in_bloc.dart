import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocs/sing_in_bloc/bloc.dart';
import '../../repositories/user_repository.dart';
import '../../util/validators.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  UserRepository _userRepository;

  SignInBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SignInState get initialState => SignInState.empty();

  @override
  Stream<SignInState> transformEvents(
    Stream<SignInEvent> events,
    Stream<SignInState> Function(SignInEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! UsernameChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is UsernameChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is UsernameChanged) {
      yield* _mapEmailChangedToState(event.username);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SignInWithCredentialsPressed) {
      yield* _mapSignInWithCredentialsPressedToState(
        username: event.username,
        password: event.password,
      );
    }
  }

  Stream<SignInState> _mapEmailChangedToState(String username) async* {
    yield state.update(
      isUsernameValid: await UserRepository.isUsernameUsed(username),
    );
  }

  Stream<SignInState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignInState> _mapSignInWithCredentialsPressedToState({
    String username,
    String password,
  }) async* {
    yield SignInState.loading();
    try {
      await _userRepository.signIn(username, password);
      yield SignInState.success();
    } catch (err) {
      print(err);
      yield SignInState.failure();
    }
  }
}