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

  set noteLabel(int newLabel) => this._label = _label;

  int get noteLabel => this._label;

  NoteModel copy() {
    return NoteModel(
        title: this._title, content: this._content, label: this._label);
  }
}
