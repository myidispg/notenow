import 'package:flutter/material.dart';

const kSurfaceColorDark = Color(0xFF1F1F1F);
const kPurpleColor = Color(0xFFBB86FC);

const kDarkThemeBackgroundColor = Color(0xFF2E2E2E);
const kLightThemeBackgroundColor = Color(0xFFFAFAFA);
const kNoteBackgroundColor = Color(0xFF353535);

const kPurpleButtonColor = Color(0xFF5C49E0);

const kGreyTextColor = Color(0xFF817F80);
const kDarkThemeWhiteGrey = Colors.white60;

const kIconSize = 30.0;

const kNoteBoxNoteStyle =
    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, letterSpacing: 1.1);

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

// Firebase
final String kDefaultEmail = 'email@email.com';
final String kTitleDocumentField = 'title';
final String kContentDocumentField = 'content';
final String kLabelDocumentField = 'label';

// Shared Preferences
final String kEmailKeySharedPreferences = 'userEmail';
final String kThemeKeySharedPreferences = 'appTheme';

// SQLite Database
final String kDatabaseName = 'notesDatabase.db';
final String kTableNotes = "notes";
final String kColumnId = "id";
final String kColumnTitle = 'title';
final String kColumnContent = 'content';
final String kColumnLabel = 'label';

const kInputFieldDecoration = InputDecoration(
  labelText: "Email",
  // errorText: "Some error occurred",
  errorStyle: TextStyle(fontSize: 14, color: Colors.red),
  errorBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPurpleColor), gapPadding: 4),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),
  ),
);

const kCapitalTextsTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w800, letterSpacing: 1.1);

enum kLoginCodesEnum { wrong_password, weak_password, successful, unknownError }
