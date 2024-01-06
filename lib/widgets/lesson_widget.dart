import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/lesson.dart';

class LessonWidget extends StatelessWidget {
  Lesson lesson;

  LessonWidget(this.lesson, {super.key});

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
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Slidable(
        startActionPane: omar
            ? ActionPane(
          motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      APIs.deleteLesson(
                          id: lesson.id!, videoPath: lesson.media!);
                      Dialogs.showSnackbar(context, 'تم حذف الدرس بنجاح');
                    },
                    icon: CupertinoIcons.delete,
                    backgroundColor: Colors.red,
                    label: 'حذف',
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                ],
              )
            : null,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * .05),
              padding: EdgeInsets.all(width * .019),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * .03),
                  color: lightGreen),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            Expanded(child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lesson.number.toString() ?? "",
                  style: const TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                Text(
                  lesson.name ?? '',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.grey,
                      fontSize: width * .025),
                ),
                const Text(
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
      ),
    );
  }
}
