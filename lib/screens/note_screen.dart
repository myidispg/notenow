import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/widgets/label_selector_dialog.dart';
import 'package:notes_app/widgets/note_writing_section.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class NoteScreen extends StatefulWidget {
  final int? noteIndex;

  NoteScreen({this.noteIndex});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late NoteModel _note;
  bool _isNoteInitialized = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!this._isNoteInitialized) {
      if (widget.noteIndex != null) {
        _note = NoteModel(
            noteTitle: Provider.of<AppState>(context)
                .notesModel
                .getNote(widget.noteIndex!)
                .noteTitle,
            noteContent: Provider.of<AppState>(context)
                .notesModel
                .getNote(widget.noteIndex!)
                .noteContent,
            noteLabel: Provider.of<AppState>(context)
                .notesModel
                .getNote(widget.noteIndex!)
                .noteLabel,
            id: Provider.of<AppState>(context)
                .notesModel
                .getNote(widget.noteIndex!)
                .id);
      } else {
        _note = NoteModel(noteContent: "");
      }
      // _note = widget.noteIndex != null
      //     ? Provider.of<AppState>(context).notesModel.getNote(widget.noteIndex!)
      //     : NoteModel(noteContent: "");
      this._isNoteInitialized = true;
    }
  }

  void editNoteTitle(String newTitle) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    _note.noteTitle = newTitle;
  }

  void editNoteContent(String newContent) {
    /// This is a callback that allows the NoteWritingScreen to edit the note
    /// object in this class.
    _note.noteContent = newContent;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kDarkThemeBackgroundColor,
        title: Text("Your note"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Every new note must have some content.
              if (_note.noteContent != "") {
                Provider.of<AppState>(context, listen: false)
                    .saveNote(_note, widget.noteIndex);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please enter some content for the note."),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Hero(
        tag: widget.noteIndex != null
            ? 'note_box_${widget.noteIndex}'
            : 'note_box',
        child: SafeArea(
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
                        child: NoteWritingSection(
                          startingTitle: _note.noteTitle,
                          startingContent: _note.noteContent,
                          editNoteTitleCallback: editNoteTitle,
                          editNoteContentCallback: editNoteContent,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    BottomNoteOptions(
                      deviceHeight: deviceHeight,
                      deviceWidth: deviceWidth,
                      note: _note,
                      deleteNoteCallback: () async {
                        if (widget.noteIndex != null)
                          Provider.of<AppState>(context, listen: false)
                              .deleteNote(_note);
                        // deleteNoteFirestore();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNoteOptions extends StatefulWidget {
  /// This will be a reference to the note object in NoteScreen.
  /// This allows access to label and content. Content for sharing.
  NoteModel note;
  final Function? deleteNoteCallback;
  final double deviceHeight;
  final double deviceWidth;

  BottomNoteOptions(
      {required this.note,
      required this.deviceHeight,
      required this.deviceWidth,
      required this.deleteNoteCallback});

  @override
  _BottomNoteOptionsState createState() => _BottomNoteOptionsState();
}

class _BottomNoteOptionsState extends State<BottomNoteOptions> {
  void changeLabelCallback(int newLabelIndex) {
    /// Callback for the AlertDialog to change label in the
    /// BottomNoteOptions class instance.
    setState(() {
      /// Since this a reference to note object in NoteScreen,
      /// changes will reflect there too.
      widget.note.noteLabel = newLabelIndex;
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
                      selectedLabel: widget.note.noteLabel,
                      deviceWidth: widget.deviceWidth,
                      changeLabelCallback: changeLabelCallback,
                    );
                  });
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.notifications_active_outlined),
          //   iconSize: 28,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            iconSize: 28,
            onPressed: () {
              this.widget.deleteNoteCallback?.call();
            },
          ),
          IconButton(
            icon: Icon(Icons.share_outlined),
            iconSize: 28,
            onPressed: () {
              if (widget.note.noteContent.isEmpty)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("There is no content in the note to share."),
                  ),
                );
              else
                Share.share(widget.note.noteContent);
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
