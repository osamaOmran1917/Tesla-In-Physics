import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/models/exam.dart';

class ExamWidget extends StatefulWidget {
  Exam exam;

  ExamWidget(this.exam);

  @override
  State<ExamWidget> createState() => _ExamWidgetState();
}

class _ExamWidgetState extends State<ExamWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height * .1),
        child: CachedNetworkImage(
          width: height * .15,
          height: height * .15,
          imageUrl: widget.exam.image ?? '',
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => CircleAvatar(
            child: Icon(CupertinoIcons.doc_chart_fill),
          ),
        ),
      ),
    );
  }
}
