import 'package:flutter/material.dart';

const kSurfaceColor = Color(0xFF1F1F1F);
const kPurpleColor = Color(0xFFC38FFF);

const kDarkThemeBackgroundColor = Color(0xFF2E2E2E);
const kNoteBackgroundColor = Color(0xFF353535);

const kGreyTextColor = Color(0xFF817F80);
const kDarkThemeWhiteGrey = Colors.white60;

const kIconSize = 30.0;

const kNoteBoxNoteStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.1);

const Map<int, Color> kLabelToColor = {
  0: Colors.lightBlueAccent,
  1: Colors.redAccent,
  2: Colors.purpleAccent,
  3: Colors.greenAccent,
  4: Colors.yellowAccent,
  5: Colors.blueAccent,
  6: Colors.orangeAccent,
  7: Colors.pinkAccent,
  8: Colors.tealAccent
};

final String kDatabaseName = 'notesDatabase.db';
final String kTableNotes = "notes";
final String kColumnTitle = 'title';
final String kColumnContent = 'content';
final String kColumnLabel = 'label';
