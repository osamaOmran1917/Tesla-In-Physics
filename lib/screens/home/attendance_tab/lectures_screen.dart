import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/screens/home/attendance_tab/set_attendance.dart';

class LecturesScreen extends StatelessWidget {
  int level, month;

  LecturesScreen(this.level, this.month, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/designed_background.jpg'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .061),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .067,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(width * .039),
                    decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(width * .05)),
                    child: const Icon(
                      Icons.keyboard_arrow_left_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'الحصة',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: width * .05,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .045,
                ),
                Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(horizontal: width * .021),
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: height * .03,
                  crossAxisSpacing: width * .03,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 1)));
                        },
                        child: LecCell(1)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 2)));
                        },
                        child: LecCell(2)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 3)));
                        },
                        child: LecCell(3)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 4)));
                        },
                        child: LecCell(4)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 5)));
                        },
                        child: LecCell(5)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 6)));
                        },
                        child: LecCell(6)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 7)));
                        },
                        child: LecCell(7)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 8)));
                        },
                        child: LecCell(8)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 9)));
                        },
                        child: LecCell(9)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 10)));
                        },
                        child: LecCell(10)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 11)));
                        },
                        child: LecCell(11)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      SetAttendance(level, month, 12)));
                        },
                        child: LecCell(12)),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}

class LecCell extends StatelessWidget {
  int lec;

  LecCell(this.lec, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * .05),
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
      child: Center(
          child: Text(
        lec.toString(),
        style: TextStyle(
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            fontSize: width * .1,
            color: lightGreen),
      )),
    );
  }
}