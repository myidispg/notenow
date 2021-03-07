class Note {
  String? _title;
  String _content;
  int _label;

  Note({String? title, required String content, int label = 1})
      : this._title = title,
        this._content = content,
        this._label = label;

  set noteTitle(String? newTitle) {
    this._title = newTitle;
  }

  String? get noteTitle => this._title;

  set noteContent(String newContent) {
    this._content = newContent;
  }

  String get noteContent => this._content;

  set noteLabel(int newLabel) {
    this._label = _label;
  }

  int get noteLabel => this._label;

  Note copy() {
    return Note(title: this._title, content: this._content, label: this._label);
  }
}
