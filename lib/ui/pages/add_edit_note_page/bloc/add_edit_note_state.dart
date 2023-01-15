part of 'add_edit_note_bloc.dart';

class AddEditNoteState extends Equatable {
  AddEditNoteState(
    this.noteObject, {
    this.noteName = const NoteName.pure(),
    this.noteContent,
    this.status = FormzStatus.pure,
  });
  final Note? noteObject;
  final NoteName noteName;
  final String? noteContent;
  final FormzStatus status;

  @override
  List<Object?> get props => [noteName, noteContent, status];

  AddEditNoteState copyWith({
    NoteName? noteName,
    String? noteContent,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return AddEditNoteState(
      noteObject,
      noteName: noteName ?? this.noteName,
      noteContent: noteContent ?? this.noteContent,
      status: status ?? this.status,
    );
  }
}
