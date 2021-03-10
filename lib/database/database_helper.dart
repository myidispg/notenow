import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;
  static final _version = 1;

  // Future<Database?> get database async {
  //   if (_database != null) return _database;
  //   _database = await _initDatabase();
  //   return _database;
  // }

  // Open the database

  Future open() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory!, kDatabaseName);
    _database =
        await openDatabase(path, version: _version, onCreate: _onCreate);
    print('database: $_database');
  }

  // _initDatabase() async {
  //   var documentsDirectory = await getDatabasesPath();
  //   String path = join(documentsDirectory!, kDatabaseName);
  //   return await openDatabase(path, version: _version, onCreate: _onCreate);
  // }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $kTableNotes (
    $kColumnTitle TEXT,
    $kColumnContent TEXT NOT NULL,
    $kColumnLabel INT NOT NULL
    )
    ''');
  }

  Future<int> insert(NoteModel note) async {
    int returnValue = await _database!.insert(kTableNotes, note.toMap());
    return returnValue;
  }

  Future<NotesModel> getAllNotes() async {
    List<Map> notesMaps = await _database!.query(kTableNotes);

    NotesModel notesModel = NotesModel();
    notesMaps.forEach((noteMap) {
      notesModel.saveNote(NoteModel(
          title: noteMap['title'],
          content: noteMap['content'],
          label: noteMap['label']));
    });

    // print('Notes from table: $notesMaps');
    return notesModel;
  }
}
