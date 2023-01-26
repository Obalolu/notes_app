import 'package:flutter/material.dart';

const kPadding = 16.0;
const kCustomToolbarHeight = 120.0;

const kEditTitleTextStyle = TextStyle(fontFamily: 'Inder', fontWeight: FontWeight.bold, fontSize: 24);
const kEditContentTextStyle = TextStyle(fontFamily: 'Inder', fontWeight: FontWeight.normal, fontSize: 16);
const kHeadingTextStyle = TextStyle(fontFamily: 'Inder', fontSize: 50.0, color: Color(0xFF000000), fontWeight: FontWeight.bold);
const kTitleTextStyle = TextStyle(fontFamily: 'Inder', fontSize: 18.0, fontWeight: FontWeight.bold);
const kContentTextStyle = TextStyle(fontFamily: 'Inder', fontSize: 15,);
const kDateTextStyle = TextStyle(fontFamily: 'Inder', fontSize: 12,);

const kTitleInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: -8),
  hintText: 'Title',
  filled: true,
  fillColor: Colors.transparent,
  border: InputBorder.none
);
const kContentInputDecoration = InputDecoration(
  hintText: 'Type something',
  border: InputBorder.none,
  fillColor: Colors.transparent,
);