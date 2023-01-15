import 'package:notes_app/data/dto/note_dto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'notes.db';
  static const _databaseVersion = 1;
  Database? _database;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE $noteTableName ($noteIdColumnName integer primary key autoincrement, $noteNameColumnName text, $noteDateColumnName text, $noteContentColumnName text, $noteStateColumnName integer) ''');
    });
  }

  Future<List<NoteDto>> getAllNotes() async {
    Database? db = await instance.database;
    var parsed = await db!.query(noteTableName);
    return parsed.map<NoteDto>((json) => NoteDto.fromJson(json)).toList();
  }

  Future<NoteDto> insertNote(NoteDto note) async {
    Database? db = await instance.database;
    var id = await db!.insert(noteTableName, note.toJson());
    return note.copyWith(id: id);
  }

  Future<bool> updateNote(NoteDto note) async {
    Database? db = await instance.database;
    final result = await db!.update(noteTableName, note.toJson(), where: '$noteIdColumnName = ?', whereArgs: [note.id]);
    return result == 1;
  }

  Future<bool> archiveNote(int noteId) async {
    Database? db = await instance.database;
    final result = await db!.update(noteTableName, {noteStateColumnName: 2}, where: '$noteIdColumnName = ?', whereArgs: [noteId]);
    return result == 1;
  }
}
