import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/widgets/floating_search_bar.dart';
import 'package:notes_app/widgets/home_nav_drawer.dart';
import 'package:notes_app/widgets/note_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_isDataInitialized) {
  //     // Provider.of<NotesModel>(context).buildDummyData();
  //     _isDataInitialized = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // initNotes(context);
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Color(0xffBB86FC),
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
              child: Provider.of<NotesModel>(context).notesCount != 0
                  ? Consumer<NotesModel>(
                      builder: (context, notes, child) {
                        return StaggeredGridView.countBuilder(
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          padding:
                              EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          crossAxisCount: 4,
                          itemCount: notes.notesCount,
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
                                title:
                                    notes.getNote(index).noteTitle!.isNotEmpty
                                        ? notes.getNote(index).noteTitle
                                        : "Note",
                                text: notes.getNote(index).noteContent,
                                labelColor: kLabelToColor[
                                    notes.getNote(index).noteLabel],
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
