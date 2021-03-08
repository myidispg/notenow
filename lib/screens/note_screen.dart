import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/widgets/label_selector_dialog.dart';
import 'package:notes_app/widgets/note_writing_section.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NoteScreen extends StatefulWidget {
  // NoteModel note;
  final Function? deleteNoteCallback;
  final Function saveNoteCallback;
  final int? noteIndex;

  NoteScreen(
      {
      // required this.note,
      this.deleteNoteCallback,
      required this.saveNoteCallback,
      this.noteIndex});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late NoteModel _note;
  bool _isNoteInitialized = false;

  @override
  void initState() {
    super.initState();

    _note = widget.noteIndex != null
        ? Provider.of<NotesModel>(context).getNote(widget.noteIndex!)
        : NoteModel(content: "");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (!this._isNoteInitialized) {
    //   _note = widget.noteIndex != null
    //       ? Provider.of<NotesModel>(context).getNote(widget.noteIndex!)
    //       : NoteModel(content: "");
    // }
  }

  void editNoteTitle(String newTitle) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    _note.noteTitle = newTitle;
    print("Inside main note screen title: $newTitle");
  }

  void editNoteContent(String newContent) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    // Provider.of<NotesModel>(context).getNote(widget.noteIndex!).noteContent =
    //     newContent;
    _note.noteContent = newContent;
    print("Inside main note screen content: $newContent");
  }

  void editNoteLabel(int newLabel) {
    /// Callback to change the label of a note.
    setState(() {
      NoteModel newNote = NoteModel(
          title: _note.noteTitle, content: _note.noteContent, label: newLabel);
      // Note newNote = widget.note.copy();
      print("Old: ${_note.hashCode}, new: ${newNote.hashCode}");
      // newNote.noteLabel = labelIndex;
      _note = newNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kDarkThemeBackgroundColor,
        title: Text("Create a note"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Every new note must have some content.
              if (_note.noteContent != "") {
                if (widget.noteIndex == null)
                  // New note is being created.
                  widget.saveNoteCallback(_note);
                else
                  // Note is edited. Tell the index too.
                  widget.saveNoteCallback(_note, widget.noteIndex);
                Navigator.pop(context);
              } else {
                // Scaffold.of(context).showSnackBar(snackbar)
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Please enter some content for the note.")));
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: deviceHeight -
                  (MediaQuery.of(context).padding.top + kToolbarHeight),
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceHeight * 0.02,
                          vertical: deviceWidth * 0.015),
                      child: Hero(
                        tag: widget.noteIndex != null
                            ? 'note_box_${widget.noteIndex}'
                            : 'note_box',
                        child: NoteWritingSection(
                          note: _note,
                          editNoteTitleCallback: editNoteTitle,
                          editNoteContentCallback: editNoteContent,
                        ),
                      ),
                    ),
                  ),
                  BottomNoteOptions(
                    deviceHeight: deviceHeight,
                    deviceWidth: deviceWidth,
                    note: _note,
                    deleteNoteCallback: widget.deleteNoteCallback,
                    editLabelCallback: editNoteLabel,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNoteOptions extends StatefulWidget {
  NoteModel note;
  final Function? deleteNoteCallback;
  final Function editLabelCallback;
  final double deviceHeight;
  final double deviceWidth;

  BottomNoteOptions(
      {required this.deviceHeight,
      required this.deviceWidth,
      required this.note,
      required this.deleteNoteCallback,
      required this.editLabelCallback});

  @override
  _BottomNoteOptionsState createState() => _BottomNoteOptionsState();
}

class _BottomNoteOptionsState extends State<BottomNoteOptions> {
  void changeLabelCallback(int labelIndex) {
    setState(() {
      NoteModel newNote = NoteModel(
          title: widget.note.noteTitle,
          content: widget.note.noteContent,
          label: labelIndex);
      // Note newNote = widget.note.copy();
      print("Old: ${widget.note.hashCode}, new: ${newNote.hashCode}");
      // newNote.noteLabel = labelIndex;
      widget.note = newNote;
      // widget.note.noteLabel = labelIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.deviceHeight * 0.09,
      color: kNoteBackgroundColor.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.star,
              color: kLabelToColor[widget.note.noteLabel],
            ),
            iconSize: 28,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return LabelSelectorDialog(
                      selectedIndex: widget.note.noteLabel,
                      deviceWidth: widget.deviceWidth,
                      changeLabelCallback: widget.editLabelCallback,
                    );
                  });
              // Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_active_outlined),
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            iconSize: 28,
            onPressed: () {
              // Remove note only if it has some content.
              this.widget.deleteNoteCallback?.call(widget.note);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.share_outlined),
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
