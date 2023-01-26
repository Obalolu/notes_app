import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  ColorButton({@required this.onPressed, @required this.color, @required this.isVisible});

  final Function onPressed;
  final String color;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.6, color: Colors.grey),
        borderRadius: BorderRadius.circular(8)
      ),
      color: Color(int.parse(color)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Container(
          width: 56,
            height: 56,
            child: Visibility(
                visible: isVisible,
                child: Icon(Icons.check, size: 32,))),
      ),
    );
  }
}


