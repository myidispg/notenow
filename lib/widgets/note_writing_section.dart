import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';

// ignore: must_be_immutable
class NoteWritingSection extends StatefulWidget {
  /// This will be a reference to whatever note object is in use.
  /// Any changes to this will reflect in the parent too.
  NoteModel note;
  Function? editNoteTitleCallback;
  Function? editNoteContentCallback;

  NoteWritingSection(
      {required this.note,
      this.editNoteTitleCallback,
      this.editNoteContentCallback});

  @override
  _NoteWritingSectionState createState() => _NoteWritingSectionState();
}

class _NoteWritingSectionState extends State<NoteWritingSection> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note.noteTitle ?? "";
    _contentController.text = widget.note
        .noteContent; // Any note object here will always have some content.
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey, width: 0.5),
          color: kNoteBackgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 24),
              ),
              style: TextStyle(color: Colors.white, fontSize: 24),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                // widget.title = value;
                widget.note.noteTitle = value;
                // widget.editNoteTitleCallback!(value);
                print("Title: ${widget.note.noteTitle}");
              },
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note",
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  // widget.content = value;
                  widget.note.noteContent = value;
                  // widget.editNoteContentCallback!(value);
                  print("Note: ${widget.note.noteContent}");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
