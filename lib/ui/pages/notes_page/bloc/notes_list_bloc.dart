import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/ui/pages/notes_page/models/notes_state_filter.dart';
import 'package:notes_app/utils/date_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/repositories/notes_repository.dart';

part 'notes_list_event.dart';
part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  NotesListBloc(NotesRepository notesRepository)
      : _notesRepository = notesRepository,
        super(NotesListState(datePicked: DateTime.now())) {
    on<NotesFetched>(getNotes);
    on<NotesStateFilterChanged>(notesStateFilterChanged);
    on<NotesSearchValueChanged>(notesSearchValueChanged,
        transformer: ((events, mapper) => events.debounceTime(const Duration(milliseconds: 100)).distinct().switchMap(mapper)));
    on<NotesPickedDateChanged>(notesPickedDateChanged);
    on<NoteArchived>(archiveNote);
  }
  final NotesRepository _notesRepository;

  Future<void> getNotes(NotesFetched event, Emitter<NotesListState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));

    await emit.forEach<List<Note>>(
      _notesRepository.getNotes(),
      onData: (notes) => state.copyWith(
        status: NotesStatus.success,
        notes: notes,
      ),
      onError: (_, __) => state.copyWith(status: NotesStatus.failure),
    );
  }

  void notesStateFilterChanged(NotesStateFilterChanged event, Emitter<NotesListState> emit) {
    emit(state.copyWith(stateFilter: event.stateFilter));
  }

  void notesSearchValueChanged(NotesSearchValueChanged event, Emitter<NotesListState> emit) {
    emit(state.copyWith(searchValue: event.searchValue));
  }

  void notesPickedDateChanged(NotesPickedDateChanged event, Emitter<NotesListState> emit) {
    emit(state.copyWith(datePicked: event.dateTime));
  }

  void archiveNote(NoteArchived event, Emitter<NotesListState> emit) {
    _notesRepository.archiveNote(event.noteId);
  }
}
