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
    if (widget.month == 3 && widget.lec == 1) {
      att = widget.user.mar_1;
      lecture = 'mar_1';
    }
    if (widget.month == 3 && widget.lec == 2) {
      att = widget.user.mar_2;
      lecture = 'mar_2';
    }
    if (widget.month == 3 && widget.lec == 3) {
      att = widget.user.mar_3;
      lecture = 'mar_3';
    }
    if (widget.month == 3 && widget.lec == 4) {
      att = widget.user.mar_4;
      lecture = 'mar_4';
    }
    if (widget.month == 3 && widget.lec == 5) {
      att = widget.user.mar_5;
      lecture = 'mar_5';
    }
    if (widget.month == 3 && widget.lec == 6) {
      att = widget.user.mar_6;
      lecture = 'mar_6';
    }
    if (widget.month == 3 && widget.lec == 7) {
      att = widget.user.mar_7;
      lecture = 'mar_7';
    }
    if (widget.month == 3 && widget.lec == 8) {
      att = widget.user.mar_8;
      lecture = 'mar_8';
    }
    if (widget.month == 3 && widget.lec == 9) {
      att = widget.user.mar_9;
      lecture = 'mar_9';
    }
    if (widget.month == 3 && widget.lec == 10) {
      att = widget.user.mar_10;
      lecture = 'mar_10';
    }
    if (widget.month == 3 && widget.lec == 11) {
      att = widget.user.mar_11;
      lecture = 'mar_11';
    }
    if (widget.month == 3 && widget.lec == 12) {
      att = widget.user.mar_12;
      lecture = 'mar_12';
    }
    if (widget.month == 4 && widget.lec == 1) {
      att = widget.user.apr_1;
      lecture = 'apr_1';
    }
    if (widget.month == 4 && widget.lec == 2) {
      att = widget.user.apr_2;
      lecture = 'apr_2';
    }
    if (widget.month == 4 && widget.lec == 3) {
      att = widget.user.apr_3;
      lecture = 'apr_3';
    }
    if (widget.month == 4 && widget.lec == 4) {
      att = widget.user.apr_4;
      lecture = 'apr_4';
    }
    if (widget.month == 4 && widget.lec == 5) {
      att = widget.user.apr_5;
      lecture = 'apr_5';
    }
    if (widget.month == 4 && widget.lec == 6) {
      att = widget.user.apr_6;
      lecture = 'apr_6';
    }
    if (widget.month == 4 && widget.lec == 7) {
      att = widget.user.apr_7;
      lecture = 'apr_7';
    }
    if (widget.month == 4 && widget.lec == 8) {
      att = widget.user.apr_8;
      lecture = 'apr_8';
    }
    if (widget.month == 4 && widget.lec == 9) {
      att = widget.user.apr_9;
      lecture = 'apr_9';
    }
    if (widget.month == 4 && widget.lec == 10) {
      att = widget.user.apr_10;
      lecture = 'apr_10';
    }
    if (widget.month == 4 && widget.lec == 11) {
      att = widget.user.apr_11;
      lecture = 'apr_11';
    }
    if (widget.month == 4 && widget.lec == 12) {
      att = widget.user.apr_12;
      lecture = 'apr_12';
    }
    if (widget.month == 5 && widget.lec == 1) {
      att = widget.user.may_1;
      lecture = 'may_1';
    }
    if (widget.month == 5 && widget.lec == 2) {
      att = widget.user.may_2;
      lecture = 'may_2';
    }
    if (widget.month == 5 && widget.lec == 3) {
      att = widget.user.may_3;
      lecture = 'may_3';
    }
    if (widget.month == 5 && widget.lec == 4) {
      att = widget.user.may_4;
      lecture = 'may_4';
    }
    if (widget.month == 5 && widget.lec == 5) {
      att = widget.user.may_5;
      lecture = 'may_5';
    }
    if (widget.month == 5 && widget.lec == 6) {
      att = widget.user.may_6;
      lecture = 'may_6';
    }
    if (widget.month == 5 && widget.lec == 7) {
      att = widget.user.may_7;
      lecture = 'may_7';
    }
    if (widget.month == 5 && widget.lec == 8) {
      att = widget.user.may_8;
      lecture = 'may_8';
    }
    if (widget.month == 5 && widget.lec == 9) {
      att = widget.user.may_9;
      lecture = 'may_9';
    }
    if (widget.month == 5 && widget.lec == 10) {
      att = widget.user.may_10;
      lecture = 'may_10';
    }
    if (widget.month == 5 && widget.lec == 11) {
      att = widget.user.may_11;
      lecture = 'may_11';
    }
    if (widget.month == 5 && widget.lec == 12) {
      att = widget.user.may_12;
      lecture = 'may_12';
    }
    if (widget.month == 6 && widget.lec == 1) {
      att = widget.user.jun_1;
      lecture = 'jun_1';
    }
    if (widget.month == 6 && widget.lec == 2) {
      att = widget.user.jun_2;
      lecture = 'jun_2';
    }
    if (widget.month == 6 && widget.lec == 3) {
      att = widget.user.jun_3;
      lecture = 'jun_3';
    }
    if (widget.month == 6 && widget.lec == 4) {
      att = widget.user.jun_4;
      lecture = 'jun_4';
    }
    if (widget.month == 6 && widget.lec == 5) {
      att = widget.user.jun_5;
      lecture = 'jun_5';
    }
    if (widget.month == 6 && widget.lec == 6) {
      att = widget.user.jun_6;
      lecture = 'jun_6';
    }
    if (widget.month == 6 && widget.lec == 7) {
      att = widget.user.jun_7;
      lecture = 'jun_7';
    }
    if (widget.month == 6 && widget.lec == 8) {
      att = widget.user.jun_8;
      lecture = 'jun_8';
    }
    if (widget.month == 6 && widget.lec == 9) {
      att = widget.user.jun_9;
      lecture = 'jun_9';
    }
    if (widget.month == 6 && widget.lec == 10) {
      att = widget.user.jun_10;
      lecture = 'jun_10';
    }
    if (widget.month == 6 && widget.lec == 11) {
      att = widget.user.jun_11;
      lecture = 'jun_11';
    }
    if (widget.month == 6 && widget.lec == 12) {
      att = widget.user.jun_12;
      lecture = 'jun_12';
    }
    if (widget.month == 7 && widget.lec == 1) {
      att = widget.user.jul_1;
      lecture = 'jul_1';
    }
    if (widget.month == 7 && widget.lec == 2) {
      att = widget.user.jul_2;
      lecture = 'jul_2';
    }
    if (widget.month == 7 && widget.lec == 3) {
      att = widget.user.jul_3;
      lecture = 'jul_3';
    }
    if (widget.month == 7 && widget.lec == 4) {
      att = widget.user.jul_4;
      lecture = 'jul_4';
    }
    if (widget.month == 7 && widget.lec == 5) {
      att = widget.user.jul_5;
      lecture = 'jul_5';
    }
    if (widget.month == 7 && widget.lec == 6) {
      att = widget.user.jul_6;
      lecture = 'jul_6';
    }
    if (widget.month == 7 && widget.lec == 7) {
      att = widget.user.jul_7;
      lecture = 'jul_7';
    }
    if (widget.month == 7 && widget.lec == 8) {
      att = widget.user.jul_8;
      lecture = 'jul_8';
    }
    if (widget.month == 7 && widget.lec == 9) {
      att = widget.user.jul_9;
      lecture = 'jul_9';
    }
    if (widget.month == 7 && widget.lec == 10) {
      att = widget.user.jul_10;
      lecture = 'jul_10';
    }
    if (widget.month == 7 && widget.lec == 11) {
      att = widget.user.jul_11;
      lecture = 'jul_11';
    }
    if (widget.month == 7 && widget.lec == 12) {
      att = widget.user.jul_12;
      lecture = 'jul_12';
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
    if (widget.month == 9 && widget.lec == 1) {
      att = widget.user.sep_1;
      lecture = 'sep_1';
    }
    if (widget.month == 9 && widget.lec == 2) {
      att = widget.user.sep_2;
      lecture = 'sep_2';
    }
    if (widget.month == 9 && widget.lec == 3) {
      att = widget.user.sep_3;
      lecture = 'sep_3';
    }
    if (widget.month == 9 && widget.lec == 4) {
      att = widget.user.sep_4;
      lecture = 'sep_4';
    }
    if (widget.month == 9 && widget.lec == 5) {
      att = widget.user.sep_5;
      lecture = 'sep_5';
    }
    if (widget.month == 9 && widget.lec == 6) {
      att = widget.user.sep_6;
      lecture = 'sep_6';
    }
    if (widget.month == 9 && widget.lec == 7) {
      att = widget.user.sep_7;
      lecture = 'sep_7';
    }
    if (widget.month == 9 && widget.lec == 8) {
      att = widget.user.sep_8;
      lecture = 'sep_8';
    }
    if (widget.month == 9 && widget.lec == 9) {
      att = widget.user.sep_9;
      lecture = 'sep_9';
    }
    if (widget.month == 9 && widget.lec == 10) {
      att = widget.user.sep_10;
      lecture = 'sep_10';
    }
    if (widget.month == 9 && widget.lec == 11) {
      att = widget.user.sep_11;
      lecture = 'sep_11';
    }
    if (widget.month == 9 && widget.lec == 12) {
      att = widget.user.sep_12;
      lecture = 'sep_12';
    }
    if (widget.month == 10 && widget.lec == 1) {
      att = widget.user.oct_1;
      lecture = 'oct_1';
    }
    if (widget.month == 10 && widget.lec == 2) {
      att = widget.user.oct_2;
      lecture = 'oct_2';
    }
    if (widget.month == 10 && widget.lec == 3) {
      att = widget.user.oct_3;
      lecture = 'oct_3';
    }
    if (widget.month == 10 && widget.lec == 4) {
      att = widget.user.oct_4;
      lecture = 'oct_4';
    }
    if (widget.month == 10 && widget.lec == 5) {
      att = widget.user.oct_5;
      lecture = 'oct_5';
    }
    if (widget.month == 10 && widget.lec == 6) {
      att = widget.user.oct_6;
      lecture = 'oct_6';
    }
    if (widget.month == 10 && widget.lec == 7) {
      att = widget.user.oct_7;
      lecture = 'oct_7';
    }
    if (widget.month == 10 && widget.lec == 8) {
      att = widget.user.oct_8;
      lecture = 'oct_8';
    }
    if (widget.month == 10 && widget.lec == 9) {
      att = widget.user.oct_9;
      lecture = 'oct_9';
    }
    if (widget.month == 10 && widget.lec == 10) {
      att = widget.user.oct_10;
      lecture = 'oct_10';
    }
    if (widget.month == 10 && widget.lec == 11) {
      att = widget.user.oct_11;
      lecture = 'oct_11';
    }
    if (widget.month == 10 && widget.lec == 12) {
      att = widget.user.oct_12;
      lecture = 'oct_12';
    }
    if (widget.month == 11 && widget.lec == 1) {
      att = widget.user.nov_1;
      lecture = 'nov_1';
    }
    if (widget.month == 11 && widget.lec == 2) {
      att = widget.user.nov_2;
      lecture = 'nov_2';
    }
    if (widget.month == 11 && widget.lec == 3) {
      att = widget.user.nov_3;
      lecture = 'nov_3';
    }
    if (widget.month == 11 && widget.lec == 4) {
      att = widget.user.nov_4;
      lecture = 'nov_4';
    }
    if (widget.month == 11 && widget.lec == 5) {
      att = widget.user.nov_5;
      lecture = 'nov_5';
    }
    if (widget.month == 11 && widget.lec == 6) {
      att = widget.user.nov_6;
      lecture = 'nov_6';
    }
    if (widget.month == 11 && widget.lec == 7) {
      att = widget.user.nov_7;
      lecture = 'nov_7';
    }
    if (widget.month == 11 && widget.lec == 8) {
      att = widget.user.nov_8;
      lecture = 'nov_8';
    }
    if (widget.month == 11 && widget.lec == 9) {
      att = widget.user.nov_9;
      lecture = 'nov_9';
    }
    if (widget.month == 11 && widget.lec == 10) {
      att = widget.user.nov_10;
      lecture = 'nov_10';
    }
    if (widget.month == 11 && widget.lec == 11) {
      att = widget.user.nov_11;
      lecture = 'nov_11';
    }
    if (widget.month == 11 && widget.lec == 12) {
      att = widget.user.nov_12;
      lecture = 'nov_12';
    }
    if (widget.month == 12 && widget.lec == 1) {
      att = widget.user.dec_1;
      lecture = 'dec_1';
    }
    if (widget.month == 12 && widget.lec == 2) {
      att = widget.user.dec_2;
      lecture = 'dec_2';
    }
    if (widget.month == 12 && widget.lec == 3) {
      att = widget.user.dec_3;
      lecture = 'dec_3';
    }
    if (widget.month == 12 && widget.lec == 4) {
      att = widget.user.dec_4;
      lecture = 'dec_4';
    }
    if (widget.month == 12 && widget.lec == 5) {
      att = widget.user.dec_5;
      lecture = 'dec_5';
    }
    if (widget.month == 12 && widget.lec == 6) {
      att = widget.user.dec_6;
      lecture = 'dec_6';
    }
    if (widget.month == 12 && widget.lec == 7) {
      att = widget.user.dec_7;
      lecture = 'dec_7';
    }
    if (widget.month == 12 && widget.lec == 8) {
      att = widget.user.dec_8;
      lecture = 'dec_8';
    }
    if (widget.month == 12 && widget.lec == 9) {
      att = widget.user.dec_9;
      lecture = 'dec_9';
    }
    if (widget.month == 12 && widget.lec == 10) {
      att = widget.user.dec_10;
      lecture = 'dec_10';
    }
    if (widget.month == 12 && widget.lec == 11) {
      att = widget.user.dec_11;
      lecture = 'dec_11';
    }
    if (widget.month == 12 && widget.lec == 12) {
      att = widget.user.dec_12;
      lecture = 'dec_12';
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