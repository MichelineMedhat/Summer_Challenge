import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:summer_challenge/util/secretKey.dart';

import '../../models/user.dart';
import '../../repositories/user_repository.dart';
import '../../util/validators.dart';
import '../sign_up_bloc/bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SignUpState get initialState => SignUpState.empty();

  @override
  Stream<SignUpState> transformEvents(
    Stream<SignUpEvent> events,
    Stream<SignUpState> Function(SignUpEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! PhoneNumberChanged &&
          event is! UsernameChanged &&
          event is! PasswordChanged &&
          event is! UsernameSubmitted);
    });
    final debounceStream = events.where((event) {
      return (event is PhoneNumberChanged ||
          event is UsernameChanged ||
          event is PasswordChanged || 
          event is UsernameSubmitted);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is PhoneNumberChanged) {
      yield* _mapPhoneNumberChangedToState(event.phoneNumber);
    } else if (event is UsernameChanged) {
      yield* _mapUsernameChangedToState(event.username);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is SecretKeyChanged){
      yield* _mapSecretKeyChangedToState(event.secretKey);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.user, event.imageData, event.extenstion);
    }
  }

  Stream<SignUpState> _mapPhoneNumberChangedToState(String phoneNumber) async* {
    yield state.update(
      isPhoneNumberValid: Validators.isValidPhoneNumber(phoneNumber),
    );
  }

    Stream<SignUpState> _mapSecretKeyChangedToState(String secretKey) async* {
    yield state.update(
      isSecretKeyValid: secretKey ==  SecretKeys.secretKey,
    );
  }

  Stream<SignUpState> _mapUsernameChangedToState(String username) async* {
    yield state.update(
      isUsernameValid: !await UserRepository.isUsernameUsed(username) && Validators.isValidUsername(username),
    );
  }

  Stream<SignUpState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignUpState> _mapFormSubmittedToState(User user, Uint8List imageData, String extenstion) async* {
    yield SignUpState.loading();
    try {
       user.profilePicture = 'https://firebasestorage.googleapis.com/v0/b/summer2020-628a8.appspot.com/o/images%2Fbasicprofilepicture.png?alt=media&token=7742bc1e-5e5f-4619-ab6f-5525be11f345';
      if(imageData != null){
      var path = await _userRepository.uploadImageFile(imageData, user.username, extenstion).then((value) => value.toString());
      user.profilePicture = path;
      }
      await _userRepository.signUp(user);
      yield SignUpState.success();
    } catch (err) {
      print(err);
      yield SignUpState.failure();
    }
  }
}
