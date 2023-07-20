import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/screens/exams_dates.dart';

class Section extends StatelessWidget {
  Color color;
  String image, lable;
  int index;

  Section(this.color, this.image, this.lable, this.index);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        if (index == 2)
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ExamsDates()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * .075),
                topLeft: Radius.circular(width * .075),
                bottomRight: index % 2 == 0
                    ? Radius.circular(width * .075)
                    : Radius.circular(0),
                bottomLeft: index % 2 == 1
                    ? Radius.circular(width * .075)
                    : Radius.circular(0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              image,
              width: width * .3,
            ),
            Text(
              lable,
              style: TextStyle(
                  fontFamily: 'MyArabicFont',
                  fontSize: width * .05,
                  color: CupertinoColors.white),
            )
          ],
        ),
      ),
    );
  }
}
