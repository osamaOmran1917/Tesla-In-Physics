import 'package:flutter/material.dart';

class ExamsDates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    ));
  }
}
