import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String title;
  Color color = Colors.black;
  double size = 16;
  TextAlign alien = TextAlign.start;
  int maxLines;
  TextOverflow textOverflow;

  MyText(
      {this.title,
      this.color,
      this.size,
      this.alien,
      this.maxLines,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Text(
      "$title",
      textAlign: alien,
      textScaleFactor: 1,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: size == null ? 16 : size - 1,
        fontFamily: "cairo",
      ),
    );
  }
}
