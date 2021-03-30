import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/widgets/note_box.dart';
import 'package:provider/provider.dart';

class NoteSearchClass extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // This will show a clear query button
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // A back button to close the search.
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // These are the suggestions when the user presses enter.
    return showSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // These are suggestions that will appear when user hasn't typed anything.
    return showSearchResults(context);
  }

  Widget showSearchResults(BuildContext context) {
    /// Tap into all the notes and find out note indexes that contain the
    /// user's search query. After that, create a Staggered Grid View just like
    /// the HomeScreen with the results. The functionality is pretty much the
    /// same as the rest. Just an extra step to populate the Staggered Grid View.

    List<int> relevantIndexes =
        Provider.of<AppState>(context).notesModel.searchNotes(query);

    if (relevantIndexes.length == 0)
      return Container(
        child: Center(
          child: Text(
            "No notes match the search query.",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

    return Consumer<AppState>(
      builder: (context, appState, child) {
        return StaggeredGridView.countBuilder(
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          crossAxisCount: 4,
          itemCount: relevantIndexes.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => Hero(
            tag: 'note_box_$index',
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => NoteScreen(
                      noteIndex: relevantIndexes[index],
                    ),
                  ),
                );
              },
              child: NoteBox(
                title: appState.notesModel
                    .getNote(relevantIndexes[index])
                    .noteTitle,
                text: appState.notesModel
                    .getNote(relevantIndexes[index])
                    .noteContent,
                labelColor: kLabelToColor[appState.notesModel
                    .getNote(relevantIndexes[index])
                    .noteLabel],
              ),
            ),
          ),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        );
      },
    );
  }
}
