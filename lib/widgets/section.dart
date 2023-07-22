import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/screens/exams/exams_dates.dart';
import 'package:omar_mostafa/screens/exams/level_exams_dates.dart';
import 'package:omar_mostafa/screens/schedule/lessons_schedule.dart';
import 'package:omar_mostafa/screens/schedule/level_schedule.dart';

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
      onTap: () async {
        if (index == 2) {
          if (omar) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ExamsDates()));
          } else {
            if (SharedData.user!.is_student) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          LevelExamsDate(SharedData.user?.level ?? 0)));
            } else {
              var retrievedUser = await APIs.getFutureOfUserById(
                  SharedData.user?.student_id ?? '');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LevelExamsDate(retrievedUser!.level)));
            }
          }
          ;
        }

        if (index == 6) {
          if (omar) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LessonsSchedule()));
          } else {
            if (SharedData.user!.is_student) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          LevelSchedule(SharedData.user?.level ?? 0)));
            } else {
              var retrievedUser = await APIs.getFutureOfUserById(
                  SharedData.user?.student_id ?? '');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LevelSchedule(retrievedUser!.level)));
            }
          }
          ;
        }
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
