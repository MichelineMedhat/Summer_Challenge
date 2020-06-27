import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isPhoneNumberValid;
  final bool isUsernameValid;
  final bool isPasswordValid;
  final bool isUsernameUsed;
  final bool isSecretKeyValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isPhoneNumberValid && isUsernameValid && isPasswordValid && isSecretKeyValid;

  SignUpState({
    @required this.isPhoneNumberValid,
    @required this.isUsernameValid,
    @required this.isPasswordValid,
    @required this.isUsernameUsed,
    @required this.isSecretKeyValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory SignUpState.empty() {
    return SignUpState(
      isPhoneNumberValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed:true,
      isSecretKeyValid:true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isPhoneNumberValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed: true,
      isSecretKeyValid:true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isPhoneNumberValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed: true,
      isSecretKeyValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isPhoneNumberValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed: true,
      isSecretKeyValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignUpState update({
    bool isPhoneNumberValid,
    bool isUsernameValid,
    bool isPasswordValid,
    bool isUsernameUsed,
    bool isSecretKeyValid,
  }) {
    return copyWith(
      isPhoneNumberValid: isPhoneNumberValid,
      isUsernameValid: isUsernameValid,
      isPasswordValid: isPasswordValid,
      isUsernameUsed: isUsernameUsed,
      isSecretKeyValid: isSecretKeyValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isPhoneNumberValid,
    bool isUsernameValid,
    bool isPasswordValid,
    bool isUsernameUsed,
    bool isSecretKeyValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isUsernameUsed: isUsernameUsed?? this.isUsernameUsed,
      isSecretKeyValid: isSecretKeyValid?? this.isSecretKeyValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignUpState {
      isPhoneNumberValid: $isPhoneNumberValid,
      isUsernameValid: $isUsernameValid,
      isPasswordValid: $isPasswordValid,
      isUsernameUsed: $isUsernameUsed,
      isSecretKeyValid: $isSecretKeyValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
