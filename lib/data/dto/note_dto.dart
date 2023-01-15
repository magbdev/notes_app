import 'package:notes_app/domain/entities/note.dart';

import '../../domain/entities/note_state.dart';

class NoteDto {
  final int id;
  final String name;
  final DateTime date;
  final String? content;
  final int state;

  NoteDto({this.id = 1, required this.name, required this.date, required this.content, required this.state});

  factory NoteDto.fromJson(Map<String, dynamic> json) => NoteDto(
      id: json[noteIdColumnName],
      name: json[noteNameColumnName],
      date: DateTime.parse(json[noteDateColumnName]),
      content: json[noteContentColumnName],
      state: json[noteStateColumnName]);

  Map<String, dynamic> toJson() =>
      {noteNameColumnName: name, noteDateColumnName: date.toIso8601String(), noteContentColumnName: content, noteStateColumnName: state};

  NoteDto copyWith({int? id, String? name, DateTime? date, String? content, int? state}) {
    return NoteDto(id: id ?? this.id, name: name ?? this.name, date: date ?? this.date, content: content ?? this.content, state: state ?? this.state);
  }
}

extension NoteDtoExtension on NoteDto {
  Note get toEntity => Note(id: id, name: name, date: date, content: content, state: NoteState.fromValue(state));
}

const noteTableName = 'notes';
const noteIdColumnName = 'id';
const noteNameColumnName = 'name';
const noteDateColumnName = 'date';
const noteContentColumnName = 'content';
const noteStateColumnName = 'state';
