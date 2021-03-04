import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class NoteWritingSection extends StatefulWidget {
  const NoteWritingSection({
    Key key,
  }) : super(key: key);

  @override
  _NoteWritingSectionState createState() => _NoteWritingSectionState();
}

class _NoteWritingSectionState extends State<NoteWritingSection> {
  String noteContent;
  String noteTitle;

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
          mainAxisSize: MainAxisSize.max,
          children: [
            TextField(
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
                noteTitle = value;
                print("Title: $noteTitle");
              },
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  noteContent = value;
                  print("Note: $noteContent");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
