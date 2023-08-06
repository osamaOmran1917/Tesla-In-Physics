import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/date_utils.dart';
import 'package:omar_mostafa/models/strategy_post.dart';

class StrategyPostWidget extends StatelessWidget {
  StrategyPost strategy_post;

  StrategyPostWidget(this.strategy_post);

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
                  style:
                  TextStyle(fontFamily: 'Cairo', color: Color(0xff79c6b3)),
                ),
              ),
              Text(
                strategy_post.title ?? '',
                style:
                TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: height * .013,
          ),
          Text(
            strategy_post.details ?? '',
            maxLines: 2,
            style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.grey,
                fontSize: width * .029),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              Text(
                  '${strategy_post.date_time?.year.toString()}/${strategy_post.date_time?.month.toString()}/${strategy_post.date_time?.day.toString()}',
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
                getFormattedTime(context: context, time: strategy_post.time!),
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
          Icon(CupertinoIcons.heart)
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
