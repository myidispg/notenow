import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/widgets/note_writing_section.dart';

class NoteScreen extends StatelessWidget {
  final heroTag;

  const NoteScreen({Key key, this.heroTag = 'note_box'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kDarkThemeBackgroundColor,
        title: Text("Create a note"),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Hero(
                  tag: this.heroTag,
                  child: NoteWritingSection(),
                ),
              ),
            ),
            BottomNoteOptions(deviceHeight: deviceHeight)
          ],
        ),
      ),
    );
  }
}

class BottomNoteOptions extends StatelessWidget {
  const BottomNoteOptions({
    Key key,
    @required this.deviceHeight,
  }) : super(key: key);

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
            icon: Icon(Icons.star),
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
