import 'package:flutter/material.dart';
import 'package:omar_mostafa/models/lessons.dart';

class LessonWidget extends StatelessWidget {
  Lesson lesson;

  LessonWidget(this.lesson);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
