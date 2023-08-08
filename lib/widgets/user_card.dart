import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/my_user.dart';

class UserCard extends StatefulWidget {
  MyUser user;
  int lec;
  int month;
  late Color color;

  UserCard(this.user, this.lec, this.month);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    late var att;
    late var lecture;
    if (widget.month == 1 && widget.lec == 1) {
      att = widget.user.jan_1;
      lecture = 'jan_1';
    }
    if (widget.month == 1 && widget.lec == 2) {
      att = widget.user.jan_2;
      lecture = 'jan_2';
    }
    if (widget.month == 1 && widget.lec == 3) {
      att = widget.user.jan_3;
      lecture = 'jan_3';
    }
    if (widget.month == 1 && widget.lec == 4) {
      att = widget.user.jan_4;
      lecture = 'jan_4';
    }
    if (widget.month == 1 && widget.lec == 5) {
      att = widget.user.jan_5;
      lecture = 'jan_5';
    }
    if (widget.month == 1 && widget.lec == 6) {
      att = widget.user.jan_6;
      lecture = 'jan_6';
    }
    if (widget.month == 1 && widget.lec == 7) {
      att = widget.user.jan_7;
      lecture = 'jan_7';
    }
    if (widget.month == 1 && widget.lec == 8) {
      att = widget.user.jan_8;
      lecture = 'jan_8';
    }
    if (widget.month == 1 && widget.lec == 9) {
      att = widget.user.jan_9;
      lecture = 'jan_9';
    }
    if (widget.month == 1 && widget.lec == 10) {
      att = widget.user.jan_10;
      lecture = 'jan_10';
    }
    if (widget.month == 1 && widget.lec == 11) {
      att = widget.user.jan_11;
      lecture = 'jan_11';
    }
    if (widget.month == 1 && widget.lec == 12) {
      att = widget.user.jan_12;
      lecture = 'jan_12';
    }
    if (widget.month == 2 && widget.lec == 1) {
      att = widget.user.feb_1;
      lecture = 'feb_1';
    }
    if (widget.month == 2 && widget.lec == 2) {
      att = widget.user.feb_2;
      lecture = 'feb_2';
    }
    if (widget.month == 2 && widget.lec == 3) {
      att = widget.user.feb_3;
      lecture = 'feb_3';
    }
    if (widget.month == 2 && widget.lec == 4) {
      att = widget.user.feb_4;
      lecture = 'feb_4';
    }
    if (widget.month == 2 && widget.lec == 5) {
      att = widget.user.feb_5;
      lecture = 'feb_5';
    }
    if (widget.month == 2 && widget.lec == 6) {
      att = widget.user.feb_6;
      lecture = 'feb_6';
    }
    if (widget.month == 2 && widget.lec == 7) {
      att = widget.user.feb_7;
      lecture = 'feb_7';
    }
    if (widget.month == 2 && widget.lec == 8) {
      att = widget.user.feb_8;
      lecture = 'feb_8';
    }
    if (widget.month == 2 && widget.lec == 9) {
      att = widget.user.feb_9;
      lecture = 'feb_9';
    }
    if (widget.month == 2 && widget.lec == 10) {
      att = widget.user.feb_10;
      lecture = 'feb_10';
    }
    if (widget.month == 2 && widget.lec == 11) {
      att = widget.user.feb_11;
      lecture = 'feb_11';
    }
    if (widget.month == 2 && widget.lec == 12) {
      att = widget.user.feb_12;
      lecture = 'feb_12';
    }
    if (widget.month == 8 && widget.lec == 1) {
      att = widget.user.aug_1;
      lecture = 'aug_1';
    }
    if (widget.month == 8 && widget.lec == 2) {
      att = widget.user.aug_2;
      lecture = 'aug_2';
    }
    if (widget.month == 8 && widget.lec == 3) {
      att = widget.user.aug_3;
      lecture = 'aug_3';
    }
    if (widget.month == 8 && widget.lec == 4) {
      att = widget.user.aug_4;
      lecture = 'aug_4';
    }
    if (widget.month == 8 && widget.lec == 5) {
      att = widget.user.aug_5;
      lecture = 'aug_5';
    }
    if (widget.month == 8 && widget.lec == 6) {
      att = widget.user.aug_6;
      lecture = 'aug_6';
    }
    if (widget.month == 8 && widget.lec == 7) {
      att = widget.user.aug_7;
      lecture = 'aug_7';
    }
    if (widget.month == 8 && widget.lec == 8) {
      att = widget.user.aug_8;
      lecture = 'aug_8';
    }
    if (widget.month == 8 && widget.lec == 9) {
      att = widget.user.aug_9;
      lecture = 'aug_9';
    }
    if (widget.month == 8 && widget.lec == 10) {
      att = widget.user.aug_10;
      lecture = 'aug_10';
    }
    if (widget.month == 8 && widget.lec == 11) {
      att = widget.user.aug_11;
      lecture = 'aug_11';
    }
    if (widget.month == 8 && widget.lec == 12) {
      att = widget.user.aug_12;
      lecture = 'aug_12';
    }
    widget.color = att == 1 ? lightGreen : Colors.white;
    return Visibility(
      visible: widget.user.id != '6kfQ8I3Q2ATNqFia04aQnELDX123',
      child: GestureDetector(
        onTap: () {
          if (att == 0) {
            setState(() {
              att = 1;
              APIs.updateAttendance(widget.user.id, 1, lecture);
            });
          } else {
            setState(() {
              att = 0;
              APIs.updateAttendance(widget.user.id, 0, lecture);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: height * .021),
          padding: EdgeInsets.all(width * .05),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .055,
                height: width * .055,
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(width),
                    border:
                        Border.all(color: Colors.grey, width: width * .003)),
              ),
              Text(
                widget.user.name,
                style: TextStyle(
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: width * .039),
              )
            ],
          ),
        ),
      ),
    );
  }
}
