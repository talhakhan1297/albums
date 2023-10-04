part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
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

  LoginState copyWith({
    Username? username,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? get usernameError {
    if (username.displayError == UsernameValidationError.invalid) {
      return Constants.invalidUsernameError;
    }
    return null;
  }

  String? get passwordError {
    if (password.displayError == PasswordValidationError.invalid) {
      return Constants.invalidPassswordError;
    }
    return null;
  }
}
