import 'package:flutter/material.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/screens/online_sync_screen.dart';
import 'package:notes_app/search_delegate/note_search_class.dart';
import 'package:provider/provider.dart';

class FloatingSearchBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  FloatingSearchBar({
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(6),
      child: Consumer<AppState>(
          builder: (context, appState, child) => Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: appState.isDarkTheme
                      ? kSurfaceColorDark.withOpacity(0.73)
                      : Colors.white,
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
                            showSearch(
                                context: context, delegate: NoteSearchClass());
                          },
                          child: Text(
                            "Search your notes",
                            style:
                                TextStyle(fontSize: 18, color: kGreyTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => OnlineSyncScreen(),
                            ),
                          );
                        },
                        child: Icon(Icons.cloud_upload_rounded,
                            color: kPurpleColor, size: kIconSize),
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
