part of 'notes_list_bloc.dart';

enum NotesStatus { initial, loading, success, failure }

class NotesListState extends Equatable {
  const NotesListState(
      {this.status = NotesStatus.initial,
      this.notes = const [],
      this.searchValue = '',
      this.stateFilter = NotesStateFilter.all,
      required this.datePicked});

  final NotesStatus status;
  final List<Note> notes;
  final String searchValue;
  final NotesStateFilter stateFilter;
  final DateTime datePicked;

  List<Note> get filteredNotes {
    var filtered = filterByState(notes);
    filtered = filterByDate(filtered);
    return filterBySearchValue(filtered);
  }

  List<Note> filterByState(List<Note> list) {
    return stateFilter.applyAll(list).toList();
  }

  List<Note> filterByDate(List<Note> list) {
    return list.where((note) => note.date.isSameDay(datePicked)).toList();
  }

  List<Note> filterBySearchValue(List<Note> list) {
    return list
        .where((note) =>
            note.name.toLowerCase().contains(searchValue) || (note.content != null ? note.content!.toLowerCase().contains(searchValue) : false))
        .toList();
  }

  NotesListState copyWith({NotesStatus? status, List<Note>? notes, String? searchValue, NotesStateFilter? stateFilter, DateTime? datePicked}) =>
      NotesListState(
          status: status ?? this.status,
          notes: notes ?? this.notes,
          searchValue: searchValue ?? this.searchValue,
          stateFilter: stateFilter ?? this.stateFilter,
          datePicked: datePicked ?? this.datePicked);

  @override
  List<Object> get props => [status, notes, searchValue, stateFilter, datePicked];
}
