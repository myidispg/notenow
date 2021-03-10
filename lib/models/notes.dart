import 'package:flutter/cupertino.dart';
import 'package:notes_app/models/note.dart';

class NotesModel extends ChangeNotifier {
  List<NoteModel> _notes = [];

  void buildDummyData() {
    List<NoteModel> notesData = [
      NoteModel(noteTitle: "Note 1", noteContent: "1Lorem Ipsum is simply "),
      NoteModel(
          noteTitle: "Note 2",
          noteContent: "2Lorem Ipsum is simply dummy text of the ",
          noteLabel: 1),
      NoteModel(
          noteTitle: "Note 3",
          noteContent:
              "3Lorem Ipsum is simply dummy text of the printing and typesetting ",
          noteLabel: 2),
      NoteModel(
          noteTitle: "Note 4",
          noteContent:
              "4Lorem Ipsum is simply dummy text of the printing and typesetting industry",
          noteLabel: 3),
      NoteModel(
          noteTitle: "Note 5",
          noteContent:
              "5Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
          noteLabel: 4),
      NoteModel(
          noteTitle: "Note 6",
          noteContent:
              "6Lorem Ipsum is simply dummy text of the printing and \ntypesetting industry. Lorem Ipsum has been \n\n\n\nthe industry's standard dummy text ",
          noteLabel: 5),
      NoteModel(
          noteTitle: "Note 7",
          noteContent:
              "7Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
          noteLabel: 6),
      NoteModel(
          noteTitle: "Note 8",
          noteContent:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          noteLabel: 7),
      NoteModel(
          noteTitle: "Note 9",
          noteContent:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          noteLabel: 8),
      NoteModel(
          noteTitle: "Note 10",
          noteContent:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          noteLabel: 1),
    ];
    notesData.forEach((note) {
      _notes.add(note);
    });
  }

  int get notesCount => _notes.length;

  NoteModel getNote(int index) => _notes[index];

  void deleteNote({required NoteModel note}) {
    NoteModel toRemove = _notes.firstWhere((element) =>
        element.noteTitle == note.noteTitle &&
        element.noteContent == note.noteContent &&
        element.noteLabel == element.noteLabel);
    _notes.remove(toRemove);
    notifyListeners();
  }

  void saveNote(NoteModel note, [int editIndex = -1]) {
    if (editIndex != -1) {
      // The note is being edited and not created.
      _notes[editIndex].noteTitle = note.noteTitle;
      _notes[editIndex].noteContent = note.noteContent;
      _notes[editIndex].noteLabel = note.noteLabel;
    } else {
      _notes.add(note);
    }
    notifyListeners();
  }

  List<int> searchNotes(String searchQuery) {
    /// Search for notes based on the contents/titles of the notes.
    /// Since the whole rendering of note on NoteScreen is dependant upon
    /// the index of the note, this method will return a list of indexes
    /// of the relevant notes. Empty List if no match found.

    List<int> relevantIndexes = [];
    _notes.asMap().forEach((index, note) {
      if (note.noteTitle!.contains(searchQuery) ||
          note.noteContent.contains(searchQuery)) {
        relevantIndexes.add(index);
      }
    });

    return relevantIndexes;
  }
}
