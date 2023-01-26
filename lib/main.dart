import 'package:flutter/material.dart';
import 'package:notes/screens/note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
    textTheme: TextTheme(
    headline1: TextStyle(
        fontFamily: 'Inder', fontWeight: FontWeight.bold, fontSize: 30),
    headline2: TextStyle(fontFamily: 'Inder'),
    headline3: TextStyle(fontFamily: 'Inder'),
    headline4: TextStyle(fontFamily: 'Inder'),
    headline5: TextStyle(fontFamily: 'Inder'),
    headline6: TextStyle(fontFamily: 'Inder'),
    subtitle1: TextStyle(fontFamily: 'Inder'),
    subtitle2: TextStyle(fontFamily: 'Inder'),
    bodyText1: TextStyle(fontFamily: 'Inder'),
    bodyText2: TextStyle(fontFamily: 'Inder'),
    caption: TextStyle(fontFamily: 'Inder'),
    button: TextStyle(fontFamily: 'Inder'),
    overline: TextStyle(fontFamily: 'Inder'),
    ),
    primarySwatch: Colors.yellow,
    ),
      home: NoteScreen(),
    );
  }
}