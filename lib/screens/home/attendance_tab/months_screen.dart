import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/screens/home/attendance_tab/lectures_screen.dart';

class MonthsScreen extends StatelessWidget {
  int level;

  MonthsScreen(this.level);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
        decoration: BoxDecoration(
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
                    child: Icon(
                      Icons.keyboard_arrow_left_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'الشهر',
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
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: height * .03,
                  crossAxisSpacing: width * .03,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 1)));
                        },
                        child: MonthCell(1)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 2)));
                        },
                        child: MonthCell(2)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 3)));
                        },
                        child: MonthCell(3)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 4)));
                        },
                        child: MonthCell(4)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 5)));
                        },
                        child: MonthCell(5)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 6)));
                        },
                        child: MonthCell(6)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 7)));
                        },
                        child: MonthCell(7)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 8)));
                        },
                        child: MonthCell(8)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 9)));
                        },
                        child: MonthCell(9)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 10)));
                        },
                        child: MonthCell(10)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 11)));
                        },
                        child: MonthCell(11)),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LecturesScreen(level, 12)));
                        },
                        child: MonthCell(12)),
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}

class MonthCell extends StatelessWidget {
  int month;

  MonthCell(this.month);

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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
          child: Text(
        month.toString(),
        style: TextStyle(
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            fontSize: width * .1,
            color: lightGreen),
      )),
    );
  }
}
