import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/lessons.dart';

class LessonWidget extends StatelessWidget {
  Lesson lesson;

  LessonWidget(this.lesson);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(width * .019),
      margin: EdgeInsets.only(bottom: height * .019),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * .03),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: lightGreen.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: height * .05),
            padding: EdgeInsets.all(width * .019),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * .03),
                color: lightGreen),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(child: Container()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                lesson.number ?? "",
                style:
                    TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
              ),
              Text(
                lesson.name ?? '',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.grey,
                    fontSize: width * .025),
              ),
              Text(
                '200',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: lightGreen,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: width * .05,
          ),
          Image.asset('assets/images/lesson_image.png')
        ],
      ),
    );
  }
}