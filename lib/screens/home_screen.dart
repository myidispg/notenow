import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
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
  bool _isDataInitialized = false;

  NotesModel notes = NotesModel();

  // void initNotes(BuildContext context) {
  //   /// Creates a repository of dummy notes. The repository is empty be default.
  //   List<NoteModel> notesData = [
  //     NoteModel(title: "Note 1", content: "1Lorem Ipsum is simply "),
  //     NoteModel(
  //         title: "Note 2",
  //         content: "2Lorem Ipsum is simply dummy text of the ",
  //         label: 1),
  //     NoteModel(
  //         title: "Note 3",
  //         content:
  //             "3Lorem Ipsum is simply dummy text of the printing and typesetting ",
  //         label: 2),
  //     NoteModel(
  //         title: "Note 4",
  //         content:
  //             "4Lorem Ipsum is simply dummy text of the printing and typesetting industry",
  //         label: 3),
  //     NoteModel(
  //         title: "Note 5",
  //         content:
  //             "5Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
  //         label: 4),
  //     NoteModel(
  //         title: "Note 6",
  //         content:
  //             "6Lorem Ipsum is simply dummy text of the printing and \ntypesetting industry. Lorem Ipsum has been \n\n\n\nthe industry's standard dummy text ",
  //         label: 5),
  //     NoteModel(
  //         title: "Note 7",
  //         content:
  //             "7Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
  //         label: 6),
  //     NoteModel(
  //         title: "Note 8",
  //         content:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //         label: 7),
  //     NoteModel(
  //         title: "Note 9",
  //         content:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //         label: 8),
  //     NoteModel(
  //         title: "Note 10",
  //         content:
  //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry.\nLorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  //         label: 1),
  //   ];
  //   notesData.forEach((element) {
  //     Provider.of<NotesModel>(context).saveNote(element);
  //     // notes.saveNote(element);
  //   });
  // }

  void deleteNote(NoteModel note) {
    setState(() {
      notes.deleteNote(note: note);
    });
  }

  void saveNote(NoteModel note, [int noteIndex = -1]) {
    setState(() {
      notes.saveNote(note, noteIndex);
    });
  }

  // StaggeredTile getStaggeredTile(int index) {
  //   /// Need to decide the grid tile length based on text length.
  //   /// The current layout looks good for 7 lines of text.
  //   /// Max extent for 7 lines is 2.2 and min for 1 line is 0.95
  //   double linesByCharCount = notes.getNote(index).noteContent.length /
  //       22; // This is the number of lines that the note is expected to occupy.
  //   int expectedLinesToOccupy = ((linesByCharCount * 100).toInt() % 100) <= 40
  //       ? linesByCharCount.floor()
  //       : linesByCharCount.ceil();
  //
  //   // final textSpan = TextSpan(text: notes[index], style: kNoteBoxNoteStyle);
  //   // final textPainter =
  //   //     TextPainter(text: textSpan, textDirection: TextDirection.ltr);
  //   // textPainter.layout(maxWidth: widgetContext.size.width);
  //   // print(textPainter.computeLineMetrics().length);
  //
  //   print(
  //       'GridView Log - Index: $index, Length/22: $expectedLinesToOccupy, exact: $linesByCharCount');
  //
  //   if (expectedLinesToOccupy == 1) return StaggeredTile.count(2, 0.88);
  //   if (expectedLinesToOccupy == 2) return StaggeredTile.count(2, 1.08);
  //   if (expectedLinesToOccupy == 3) return StaggeredTile.count(2, 1.18);
  //   if (expectedLinesToOccupy == 4) return StaggeredTile.count(2, 1.20);
  //   if (expectedLinesToOccupy == 5) return StaggeredTile.count(2, 1.5);
  //   if (expectedLinesToOccupy == 6) return StaggeredTile.count(2, 1.68);
  //   if (expectedLinesToOccupy == 7) return StaggeredTile.count(2, 1.85);
  //
  //   return StaggeredTile.count(2, 2.05); // If lines more than 7
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataInitialized) {
      Provider.of<NotesModel>(context).buildDummyData();
      _isDataInitialized = true;
    }
  }

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
              child: Consumer<NotesModel>(
                builder: (context, notes, child) {
                  return StaggeredGridView.countBuilder(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    crossAxisCount: 4,
                    itemCount: notes.notesCount,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Hero(
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
                          title: notes.getNote(index).noteTitle,
                          text: notes.getNote(index).noteContent,
                          labelColor:
                              kLabelToColor[notes.getNote(index).noteLabel],
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
