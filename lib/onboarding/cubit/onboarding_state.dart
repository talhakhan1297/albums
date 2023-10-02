part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Username username;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        username,
        password,
        status,
        isValid,
        errorMessage,
      ];

  OnboardingState copyWith({
    Username? username,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return OnboardingState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get usernameError {
    if (username.isPure) return null;
    if (username.error == UsernameValidationError.invalid) {
      return 'Please enter a valid username.';
    } else if (errorMessage != null) {
      return errorMessage;
    }
    return null;
  }

  String? get passwordError {
    if (password.isPure) return null;
    if (password.error == PasswordValidationError.invalid) {
      return 'Please enter a valid password.';
    }
    return null;
  }
}
