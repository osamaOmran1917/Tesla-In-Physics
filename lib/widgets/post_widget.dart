import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/post.dart';

class PostWidget extends StatelessWidget {
  Post post;

  PostWidget(this.post);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .1,
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
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Slidable(
        startActionPane: omar
            ? ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      APIs.deletePost(id: post.id!);
                    },
                    icon: CupertinoIcons.delete,
                    backgroundColor: Colors.red,
                    label: 'حذف',
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                ],
              )
            : null,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .03, vertical: height * .005),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * .025),
                  color: Color(0xffebf6ed)),
              child: Text(
                post.textDate ?? '',
                style: TextStyle(fontFamily: 'Cairo', color: lightGreen),
              ),
            ),
            Expanded(child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  post.title ?? '',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                ),
                Text(
                  post.details ?? '',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.grey,
                      fontSize: width * .025),
                )
              ],
            ),
            SizedBox(
              width: width * .05,
            ),
            CircleAvatar(
              backgroundColor: Color(0xffebf6ed),
              child: Icon(
                Icons.notifications_none,
                color: lightGreen,
              ),
            )
          ],
        ),
      ),
    );
  }
}