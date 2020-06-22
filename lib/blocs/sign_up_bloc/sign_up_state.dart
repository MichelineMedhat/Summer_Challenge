import 'package:meta/meta.dart';

@immutable
class SignUpState {
  final bool isNameValid;
  final bool isUsernameValid;
  final bool isPasswordValid;
  final bool isUsernameUsed;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isNameValid && isUsernameValid && isPasswordValid;

  SignUpState({
    @required this.isNameValid,
    @required this.isUsernameValid,
    @required this.isPasswordValid,
    @required this.isUsernameUsed,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory SignUpState.empty() {
    return SignUpState(
      isNameValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed:true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isNameValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isNameValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isNameValid: true,
      isUsernameValid: true,
      isPasswordValid: true,
      isUsernameUsed: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  SignUpState update({
    bool isNameValid,
    bool isUsernameValid,
    bool isPasswordValid,
    bool isUsernameUsed,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isUsernameValid: isUsernameValid,
      isPasswordValid: isPasswordValid,
      isUsernameUsed: isUsernameUsed,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignUpState copyWith({
    bool isNameValid,
    bool isUsernameValid,
    bool isPasswordValid,
    bool isUsernameUsed,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
      isNameValid: isNameValid ?? this.isNameValid,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isUsernameUsed: isUsernameUsed?? this.isUsernameUsed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignUpState {
      isNameValid: $isNameValid,
      isUsernameValid: $isUsernameValid,
      isPasswordValid: $isPasswordValid,
      isUsernameUsed: $isUsernameUsed,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
