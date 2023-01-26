import 'package:flutter/material.dart';
import 'package:notes/screens/edit_screen.dart';
import 'package:notes/services/database_helper.dart';
import 'package:notes/utilities/constants.dart';
import 'package:notes/utilities/note_card.dart';
import 'package:notes/utilities/standard_staggered_grid.dart';
import 'package:notes/utilities/transparent_route.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {



  Future<List<Map<String, dynamic>>> queryAll() async {
    return await DatabaseHelper.instance.queryAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: kCustomToolbarHeight,
        elevation: 0,
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  'Notes',
                  style: kHeadingTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: CircleAvatar(
                  radius: 24,
                  child: Icon(Icons.person),
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: queryAll(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.none:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.active:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.done:
                  // TODO: Handle this case.
                  break;
              }

              final notes = snapshot.data;

              if (snapshot.hasData && notes.isNotEmpty)
                return StandardStaggeredGrid(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) => Hero(
                    tag: 'noteTag$index',
                    child: NoteCard(
                      color: Color(int.parse(notes[index]['color'])),
                      title: notes[index]['title'],
                      content: notes[index]['content'],
                      lastUpdated: notes[index]['lastUpdated'],
                      onTap: () async{
                        await Navigator.of(context).push(TransparentRoute(builder: (context) => EditScreen(id: notes[index]['id'], title: notes[index]['title'], content: notes[index]['content'], lastUpdated: notes[index]['lastUpdated'], color: notes[index]['color'], index: index,)));
                        setState(() {
                        });
                      },
                    ),
                  ),
                );
              else //`snapShot.hasData` can be false if the `snapshot.data` is null
                return Center(
                  child: Text('No Notes Found', style: kTitleTextStyle),
                );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'noteTag',
        onPressed: () async{
          await Navigator.of(context).push(
              TransparentRoute(builder: (BuildContext context) => EditScreen())
          );
            setState(() {
            });
        },
        child: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
