import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/my_user.dart';

class UserCard extends StatefulWidget {
  MyUser user;
  Color color = Colors.white;

  UserCard(this.user);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        if (widget.color == Colors.white) {
          setState(() {
            widget.color = lightGreen;
            APIs.updateAttendance(widget.user.id, 1);
          });
        } else {
          setState(() {
            widget.color = Colors.white;
            APIs.updateAttendance(widget.user.id, -1);
          });
        }
      },
      child: Container(
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
                  border: Border.all(color: Colors.grey, width: width * .003)),
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
    );
  }
}