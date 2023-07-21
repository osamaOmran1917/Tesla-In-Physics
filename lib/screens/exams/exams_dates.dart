import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/screens/exams/level_exams_dates.dart';

class ExamsDates extends StatefulWidget {
  @override
  State<ExamsDates> createState() => _ExamsDatesState();
}

class _ExamsDatesState extends State<ExamsDates> {
  List<Exam> list = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff39A552),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
        title: Text(
          'أ. عُمَرْ مُصْطَفَى',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'MyArabicFont',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: height * .05,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LevelExamsDate(1)));
            },
            child: Container(
              width: width * .55,
              height: height * .21,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(width * .05),
                      bottomLeft: Radius.circular(width * .05)),
                  color: Color(0xffc91c22)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/1.png',
                    width: width * .21,
                  ),
                  Text(
                    'الصف الأول',
                    style: TextStyle(
                        fontFamily: 'MyArabicFont',
                        fontSize: width * .05,
                        color: CupertinoColors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .05,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LevelExamsDate(2)));
            },
            child: Container(
              width: width * .55,
              height: height * .21,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * .05),
                      bottomRight: Radius.circular(width * .05)),
                  color: Color(0xff003E90)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/2.png',
                    width: width * .21,
                  ),
                  Text(
                    'الصف الثاني',
                    style: TextStyle(
                        fontFamily: 'MyArabicFont',
                        fontSize: width * .05,
                        color: CupertinoColors.white),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .05,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LevelExamsDate(3)));
            },
            child: Container(
              width: width * .55,
              height: height * .21,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(width * .05),
                      bottomLeft: Radius.circular(width * .05)),
                  color: Color(0xffED1E79)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/images/3.png',
                    width: width * .21,
                  ),
                  Text(
                    'الصف الثالث',
                    style: TextStyle(
                        fontFamily: 'MyArabicFont',
                        fontSize: width * .05,
                        color: CupertinoColors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
