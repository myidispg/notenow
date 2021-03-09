import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

// ignore: must_be_immutable
class NoteWritingSection extends StatefulWidget {
  String? startingTitle;
  String startingContent;
  Function editNoteTitleCallback;
  Function editNoteContentCallback;

  NoteWritingSection(
      {this.startingTitle,
      required this.startingContent,
      required this.editNoteTitleCallback,
      required this.editNoteContentCallback});

  @override
  _NoteWritingSectionState createState() => _NoteWritingSectionState();
}

class _NoteWritingSectionState extends State<NoteWritingSection> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.startingTitle ?? "";
    _contentController.text = widget
        .startingContent; // Any note object here will always have some content.
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
                widget.editNoteTitleCallback(value);
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
                  widget.editNoteContentCallback(value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
