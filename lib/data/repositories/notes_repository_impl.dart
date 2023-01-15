import 'package:injectable/injectable.dart';
import 'package:notes_app/data/dto/note_dto.dart';
import 'package:notes_app/domain/entities/note.dart';
import 'package:notes_app/domain/entities/note_state.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../data_source/database_helper.dart';

@Singleton(as: NotesRepository)
class NotesRepositoryImpl extends NotesRepository {
  final dbHelper = DatabaseHelper.instance;
  final _noteStreamController = BehaviorSubject<List<Note>>();

  NotesRepositoryImpl() {
    fetchNotesList().then((value) => _noteStreamController.add(value));
  }
  @override
  Future<List<Note>> fetchNotesList() async {
    var notes = await dbHelper.getAllNotes();
    return notes.map((e) => e.toEntity).toList();
  }

  @override
  Future<void> addNewNote(String name, String? content) async {
    NoteDto noteDto = NoteDto(name: name, date: DateTime.now().toUtc(), content: content, state: 0);
    var item = await dbHelper.insertNote(noteDto);
    final notes = [..._noteStreamController.value, item.toEntity];
    _noteStreamController.add(notes);
  }

  @override
  Future<void> updateNote(Note note) async {
    NoteDto noteDto = NoteDto(id: note.id, name: note.name, date: note.date, content: note.content, state: note.state.value);
    await dbHelper.updateNote(noteDto);
    var list = List<Note>.from(_noteStreamController.value);
    list[list.indexWhere((element) => element.id == note.id)] = note;
    _noteStreamController.add(list);
  }

  @override
  Stream<List<Note>> getNotes() => _noteStreamController.stream;

  @override
  Future<void> archiveNote(int noteId) async {
    await dbHelper.archiveNote(noteId);
    var list = List<Note>.from(_noteStreamController.value);
    var indexInList = list.indexWhere((element) => element.id == noteId);
    list[indexInList] = list[indexInList].copyWith(state: NoteState.archived);
    _noteStreamController.add(list);
  }
}
