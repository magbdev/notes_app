import 'package:formz/formz.dart';

/// Validation errors for the Brand
enum NoteNameValidationError {
  // empty error
  empty
}

/// Form input for an brand input
class NoteName extends FormzInput<String, NoteNameValidationError> {
  const NoteName.pure([super.value = '']) : super.pure();

  const NoteName.dirty([super.value = '']) : super.dirty();

  @override
  NoteNameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : NoteNameValidationError.empty;
  }
}
