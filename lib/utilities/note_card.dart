import 'package:flutter/material.dart';
import 'package:notes/utilities/constants.dart';

class NoteCard extends StatelessWidget {

  NoteCard({@required this.color, @required this.title, @required this.content, @required this.lastUpdated, this.onTap});

  final Color color;
  final String title;
  final String content;
  final String lastUpdated;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 1, color: Colors.grey)
      ),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kTitleTextStyle,
                maxLines: 2,
              ),
              Text(
                content,
                style: kContentTextStyle,
                maxLines: 13,
              ),
              Text(
                lastUpdated,
                style: kDateTextStyle,
                maxLines: 13,
              )
            ],
          ),
        ),
      ),
    );
  }
}
