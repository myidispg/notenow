import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:provider/provider.dart';

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
    return Consumer<AppState>(
      builder: (context, appState, child) => Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
              color: appState.isDarkTheme
                  ? kLightThemeBackgroundColor
                  : kDarkThemeBackgroundColor,
              width: 0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appState.isDarkTheme
                        ? kLightThemeBackgroundColor
                        : kDarkThemeBackgroundColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appState.isDarkTheme
                        ? kLightThemeBackgroundColor
                        : kDarkThemeBackgroundColor,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appState.isDarkTheme
                        ? kLightThemeBackgroundColor
                        : kDarkThemeBackgroundColor,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                hintText: "Title",
                hintStyle: TextStyle(fontSize: 24),
              ),
              style: TextStyle(fontSize: 24),
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
