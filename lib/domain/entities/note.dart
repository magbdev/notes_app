import 'package:notes_app/domain/entities/note_state.dart';

class Note {
  final int id;
  final String name;
  final DateTime date;
  final String? content;
  final NoteState state;

  Note({this.id = 1, required this.name, required this.date, this.content, required this.state});

  Note copyWith({int? id, String? name, DateTime? date, String? content, NoteState? state}) {
    return Note(id: id ?? this.id, name: name ?? this.name, date: date ?? this.date, content: content ?? this.content, state: state ?? this.state);
  }
}
