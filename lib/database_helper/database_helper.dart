import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseVersion = 1;

  // Make it a singleton class to allow access to only one instance of class
  // and hence only one connection to db
  DatabaseHelper.__privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.__privateConstructor();

  late Database _database;

  Future<void> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, kDatabaseName);

    _database = await openDatabase(path, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE $kTableNotes (
        $kColumnId STRING PRIMARY KEY,
        $kColumnTitle TEXT,
        $kColumnContent TEXT NOT NULL,
        $kColumnLabel INTEGER NOT NULL
      )''');
    });
  }

  Future<NotesModel> getAllNotes() async {
    List<Map> maps = await _database.query(kTableNotes);
    NotesModel notes = NotesModel();
    maps.forEach((element) {
      notes.saveNote(NoteModel(
          id: element[kColumnId],
          noteTitle: element[kColumnTitle],
          noteContent: element[kColumnContent],
          noteLabel: element[kColumnLabel]));
    });
    print('Notes in database: $maps');
    return notes;
  }

  Future<void> insert(NoteModel note) async {
    await _database.insert(kTableNotes, note.toMap());
  }

  Future<void> update(NoteModel note) async {
    await _database.update(kTableNotes, note.toMap(),
        where: '$kColumnId = ?', whereArgs: [note.id]);
  }

  Future<void> delete(NoteModel note) async {
    await _database
        .delete(kTableNotes, where: '$kColumnId = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNotesDatabase() async {
    // Remove the database and all the entries
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, kDatabaseName);

    await deleteDatabase(path);
  }
}
