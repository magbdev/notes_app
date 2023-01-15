import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';
import 'package:notes_app/ui/pages/add_edit_note_page/models/note_name.dart';

part 'add_edit_note_event.dart';
part 'add_edit_note_state.dart';

class AddEditNoteBloc extends Bloc<AddEditNoteEvent, AddEditNoteState> {
  AddEditNoteBloc(Note? note, NotesRepository notesRepository)
      : _noteData = note,
        _notesRepository = notesRepository,
        super(note != null ? AddEditNoteState(note, noteName: NoteName.pure(note.name), noteContent: note.content) : AddEditNoteState(note)) {
    on<NoteNameChanged>(noteNameChanged);
    on<NoteContentChanged>(noteContentChanged);
    on<SaveNotePressed>(saveNote);
  }
  final NotesRepository _notesRepository;
  final Note? _noteData;

  void noteNameChanged(NoteNameChanged event, Emitter<AddEditNoteState> emit) {
    final name = NoteName.dirty(event.value);
    emit(
      state.copyWith(
        noteName: name,
        status: Formz.validate([name]),
      ),
    );
  }

  void noteContentChanged(NoteContentChanged event, Emitter<AddEditNoteState> emit) {
    final name = NoteName.dirty(state.noteName.value);
    emit(
      state.copyWith(
        noteContent: event.value,
        status: Formz.validate([name]),
      ),
    );
  }

  void saveNote(SaveNotePressed event, Emitter<AddEditNoteState> emit) {
    if (state.status.isInvalid) return;
    if (_noteData != null) {
      var note = Note(id: _noteData!.id, name: state.noteName.value, content: state.noteContent, date: _noteData!.date, state: _noteData!.state);
      _notesRepository.updateNote(note);
    } else {
      _notesRepository.addNewNote(state.noteName.value, state.noteContent);
    }
  }
}
