part of 'notes_list_bloc.dart';

abstract class NotesListEvent extends Equatable {
  const NotesListEvent();

  @override
  List<Object> get props => [];
}

class NotesFetched extends NotesListEvent {
  @override
  List<Object> get props => [];
}

class NotesStateFilterChanged extends NotesListEvent {
  final NotesStateFilter stateFilter;

  const NotesStateFilterChanged(this.stateFilter);

  @override
  List<Object> get props => [stateFilter];
}

class NotesSearchValueChanged extends NotesListEvent {
  final String searchValue;

  const NotesSearchValueChanged(this.searchValue);

  @override
  List<Object> get props => [searchValue];
}

class NotesPickedDateChanged extends NotesListEvent {
  final DateTime dateTime;

  const NotesPickedDateChanged(this.dateTime);

  @override
  List<Object> get props => [dateTime];
}

class NoteArchived extends NotesListEvent {
  final int noteId;

  const NoteArchived(this.noteId);

  @override
  List<Object> get props => [noteId];
}
