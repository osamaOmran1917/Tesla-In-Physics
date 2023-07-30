import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';

class Cell extends StatelessWidget {
  String text;
  Color color, textColor;
  double cellWidth;

  Cell(this.text, this.color, this.cellWidth, {this.textColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(right: width * .05),
      height: height * .041,
      width: cellWidth,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(width * .019),
        boxShadow: [
          BoxShadow(
            color: lightGreen.withOpacity(0.17),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontFamily: 'Cairo', color: textColor),
        ),
      ),
    );
  }
}
