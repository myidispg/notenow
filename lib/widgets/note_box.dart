import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class NoteBox extends StatelessWidget {
  final Color labelColor;
  final text;
  final title;

  const NoteBox(
      {Key key,
      this.labelColor = Colors.purpleAccent,
      this.text,
      this.title = "Note"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: kNoteBackgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: labelColor,
                        size: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          this.title,
                          style: kNoteBoxNoteStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 0.5,
                ),
              ],
            ),
            Text(
              text,
              style: TextStyle(height: 1.2),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 8,
            )
          ],
        ),
      ),
    );
  }
}
