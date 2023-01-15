import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/entities/note_state.dart';

enum NotesStateFilter {
  newEdit,
  approved,
  archived,
  all;

  @override
  String toString() {
    switch (this) {
      case NotesStateFilter.newEdit:
        return 'Nowe/edytowane';
      case NotesStateFilter.approved:
        return 'Zatwierdzone';
      case NotesStateFilter.archived:
        return 'Zarchiwizowane';
      case NotesStateFilter.all:
        return 'Wszystkie';
    }
  }
}

extension NotesStateFilterX on NotesStateFilter {
  bool apply(Note note) {
    switch (this) {
      case NotesStateFilter.all:
        return true;
      case NotesStateFilter.newEdit:
        return note.state == NoteState.newEdit;
      case NotesStateFilter.approved:
        return note.state == NoteState.approved;
      case NotesStateFilter.archived:
        return note.state == NoteState.archived;
    }
  }

  Iterable<Note> applyAll(Iterable<Note> notes) {
    return notes.where(apply);
  }
}
