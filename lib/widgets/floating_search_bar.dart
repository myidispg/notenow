import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/screens/login_screen.dart';
import 'package:notes_app/search_delegate/note_search_class.dart';

class FloatingSearchBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  FloatingSearchBar({
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Icon(Icons.menu, size: kIconSize),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: NoteSearchClass());
                  },
                  child: Text(
                    "Search your notes",
                    style: TextStyle(fontSize: 18, color: kGreyTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => LoginScreen(),
                    ),
                  );
                },
                child: Icon(Icons.account_circle_sharp,
                    color: kPurpleColor, size: kIconSize),
              )
            ],
          ),
        ),
      ),
    );
  }
}
