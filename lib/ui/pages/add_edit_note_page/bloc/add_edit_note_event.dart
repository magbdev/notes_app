part of 'add_edit_note_bloc.dart';

@immutable
abstract class AddEditNoteEvent {}

class NoteNameChanged extends AddEditNoteEvent {
  final String value;

  NoteNameChanged(this.value);
}

class NoteContentChanged extends AddEditNoteEvent {
  final String value;

  NoteContentChanged(this.value);
}

class SaveNotePressed extends AddEditNoteEvent {}
