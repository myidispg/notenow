import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/widgets/floating_search_bar.dart';
import 'package:notes_app/widgets/home_nav_drawer.dart';
import 'package:notes_app/widgets/note_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: kPurpleColor,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteScreen(),
            ),
          );
        },
      ),
      drawer: HomeNavDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingSearchBar(scaffoldKey: _scaffoldKey),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 4.0),
              child: Text(
                "Your Notes",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Provider.of<AppState>(context).notesModel.notesCount != 0
                  ? Consumer<AppState>(
                      builder: (context, appState, child) {
                        return StaggeredGridView.countBuilder(
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          crossAxisCount: 4,
                          itemCount: appState.notesModel.notesCount,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              Hero(
                            tag: 'note_box_$index',
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (builder) => NoteScreen(
                                      noteIndex: index,
                                    ),
                                  ),
                                );
                              },
                              child: NoteBox(
                                title: appState.notesModel
                                            .getNote(index)
                                            .noteTitle !=
                                        null
                                    ? appState.notesModel
                                        .getNote(index)
                                        .noteTitle
                                    : "Note",
                                text: appState.notesModel
                                    .getNote(index)
                                    .noteContent,
                                labelColor: kLabelToColor[appState.notesModel
                                    .getNote(index)
                                    .noteLabel],
                              ),
                            ),
                          ),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(2),
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          "You have not added any notes.\n\nPlease login again if you are a returning user.",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
