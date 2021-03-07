import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/widgets/note_writing_section.dart';

// ignore: must_be_immutable
class NoteScreen extends StatefulWidget {
  final String heroTag;
  Note note;
  final Function? deleteNoteCallback;
  final Function saveNoteCallback;
  final int? noteIndex;

  NoteScreen(
      {required this.note,
      this.deleteNoteCallback,
      required this.saveNoteCallback,
      this.noteIndex,
      this.heroTag = 'note_box'});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  void editNoteTitle(String newTitle) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    widget.note.noteTitle = newTitle;
    print("Inside main note screen title: $newTitle");
  }

  void editNoteContent(String newContent) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    widget.note.noteContent = newContent;
    print("Inside main note screen content: $newContent");
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
              if (widget.note.noteContent != "") {
                if (widget.noteIndex == null)
                  // New note is being created.
                  widget.saveNoteCallback(widget.note);
                else
                  // Note is edited. Tell the index too.
                  widget.saveNoteCallback(widget.note, widget.noteIndex);
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
                        tag: this.widget.heroTag,
                        child: NoteWritingSection(
                          note: widget.note,
                          editNoteTitleCallback: editNoteTitle,
                          editNoteContentCallback: editNoteContent,
                        ),
                      ),
                    ),
                  ),
                  BottomNoteOptions(
                    deviceHeight: deviceHeight,
                    note: widget.note,
                    deleteNoteCallback: widget.deleteNoteCallback,
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

class BottomNoteOptions extends StatelessWidget {
  final Note note;
  final Function? deleteNoteCallback;

  BottomNoteOptions(
      {required this.deviceHeight,
      required this.note,
      required this.deleteNoteCallback});

  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.09,
      color: kNoteBackgroundColor.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.star,
              color: kLabelToColor[note.noteLabel],
            ),
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context);
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
              this.deleteNoteCallback?.call(note);
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
