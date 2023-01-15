import 'package:notes_app/domain/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> fetchNotesList();
  Future<void> addNewNote(String name, String? content);
  Future<void> updateNote(Note note);
  Stream<List<Note>> getNotes();
  Future<void> archiveNote(int noteId);
}
