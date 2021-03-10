import 'package:notes_app/constants.dart';

class NoteModel {
  String? _title;
  String _content;
  int _label;

  NoteModel({String? title, required String content, int label = 0})
      : this._title = title,
        this._content = content,
        this._label = label;

  set noteTitle(String? newTitle) => this._title = newTitle;

  String? get noteTitle => this._title;

  set noteContent(String newContent) => this._content = newContent;

  String get noteContent => this._content;

  set noteLabel(int newLabel) => this._label = newLabel;

  int get noteLabel => this._label;

  // DATABASE HELPERS

  // A constructor to create an object directly from the Database.
  // NoteModel.fromMap(Map<String, dynamic> map) {
  //   _title = map[kColumnTitle];
  //   _content = map[kColumnContent];
  //   _label = map[kColumnLabel];
  // }

  Map<String, dynamic?> toMap() {
    var map = <String, dynamic>{kColumnContent: _content, kColumnLabel: _label};

    if (_title != null) {
      map[kColumnTitle] = _title;
    }

    return map;
  }
}
