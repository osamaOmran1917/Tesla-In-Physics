import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/date_utils.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/strategy_post.dart';

class StrategyPostWidget extends StatefulWidget {
  StrategyPost strategy_post;

  StrategyPostWidget(this.strategy_post);

  @override
  State<StrategyPostWidget> createState() => _StrategyPostWidgetState();
}

class _StrategyPostWidgetState extends State<StrategyPostWidget> {
  List likes = [];

  @override
  void initState() {
    super.initState();
    _getFieldValue();
  }

  Future<void> _getFieldValue() async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(APIs.user.uid)
        .get();
    var data = documentSnapshot.data();
    setState(() {
      likes = data!['likes'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * .05),
      padding: EdgeInsets.only(
          top: height * .021, right: width * .05, left: width * .05),
      width: width * .9,
      height: height * .2,
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
      child: Slidable(
        startActionPane: omar
            ? ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      APIs.deleteStrategyPost(id: widget.strategy_post.id!);
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * .037),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * .015),
                      color: Color(0xffd9f2ee)),
                  child: Text(
                    'جديد',
                    style: TextStyle(
                        fontFamily: 'Cairo', color: Color(0xff79c6b3)),
                  ),
                ),
                Text(
                  widget.strategy_post.title ?? '',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: height * .013,
            ),
            Flexible(
                child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.grey,
                      fontSize: width * .029),
                  text: widget.strategy_post.details ?? ''),
            )),
            SizedBox(
              height: height * .01,
            ),
            Row(
              children: [
                Text(
                    '${widget.strategy_post.date_time?.year.toString()}/${widget.strategy_post.date_time?.month.toString()}/${widget.strategy_post.date_time?.day.toString()}',
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                SizedBox(
                  width: width * .021,
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: lightGreen,
                ),
                Spacer(),
                Text(
                  getFormattedTime(
                      context: context, time: widget.strategy_post.time!),
                  style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                ),
                SizedBox(
                  width: width * .021,
                ),
                Icon(
                  Icons.access_time_rounded,
                  color: lightGreen,
                )
              ],
            ),
            SizedBox(
              height: height * .005,
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    if (likes.contains(widget.strategy_post.id)) {
                      likes.remove(widget.strategy_post.id);
                      APIs.updateLikes(APIs.user.uid, likes);
                    } else {
                      likes.add(widget.strategy_post.id);
                      APIs.updateLikes(APIs.user.uid, likes);
                    }
                  });
                },
                child: likes.contains(widget.strategy_post.id)
                    ? Icon(
                        CupertinoIcons.heart_fill,
                        color: lightGreen,
                      )
                    : Icon(
                        CupertinoIcons.heart,
                      ))
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
