import 'package:formz/formz.dart';

/// Validation errors for the [Username] [FormzInput].
enum UsernameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template username}
/// Form input for an username input.
/// {@endtemplate}
class Username extends FormzInput<String, UsernameValidationError> {
  /// {@macro username}
  const Username.pure() : super.pure('');

  /// {@macro username}
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String? value) {
    return (value ?? '').length > 3 && (value ?? '').length < 50
        ? null
        : UsernameValidationError.invalid;
  }
}
