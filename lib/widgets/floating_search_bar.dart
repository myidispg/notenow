import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

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
              Text(
                "Search your notes",
                style: TextStyle(fontSize: 18, color: kGreyTextColor),
              ),
              GestureDetector(
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
