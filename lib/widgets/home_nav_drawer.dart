import 'package:flutter/material.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/widgets/about_section.dart';
import 'package:provider/provider.dart';

class HomeNavDrawer extends StatefulWidget {
  @override
  _HomeNavDrawerState createState() => _HomeNavDrawerState();
}

class _HomeNavDrawerState extends State<HomeNavDrawer> {
  bool isDarkThemeOn = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 20.0, bottom: 4.0),
              child: Text(
                "NoteNow",
                style: TextStyle(fontSize: 26),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: kDarkThemeWhiteGrey,
            ),
            SwitchListTile(
              value: Provider.of<AppState>(context).isDarkTheme,
              onChanged: (value) {
                setState(() {
                  isDarkThemeOn = value;
                  Provider.of<AppState>(context, listen: false)
                      .setThemeBoolean(value);
                });
              },
              title: Text(
                "Dark Mode",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              secondary: isDarkThemeOn
                  ? Icon(Icons.wb_sunny_rounded)
                  : Icon(Icons.wb_sunny_outlined),
            ),
            Divider(
              thickness: 1.0,
              color: kDarkThemeWhiteGrey,
            ),
            AboutSection()
          ],
        ),
      ),
    );
  }
}
