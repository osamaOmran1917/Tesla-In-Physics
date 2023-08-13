import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/exam.dart';

class ExamWidget extends StatefulWidget {
  Exam exam;

  ExamWidget(this.exam);

  bool _showOptions = false;

  @override
  State<ExamWidget> createState() => _ExamWidgetState();
}

class _ExamWidgetState extends State<ExamWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(bottom: height * .025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => setState(() {
              widget._showOptions = !widget._showOptions;
            }),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width * .07),
              child: CachedNetworkImage(
                width: height * .25,
                height: height * .25,
                imageUrl: widget.exam.image ?? '',
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(CupertinoIcons.doc_chart_fill),
                ),
              ),
            ),
          ),
          if (omar)
            Visibility(
                visible: widget._showOptions,
                child: InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * .07)),
                          title: Text(
                            'هل تريد حذف هذا الاختبار؟',
                            style: TextStyle(fontFamily: 'cairo'),
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'نعم',
                                style: TextStyle(
                                    fontFamily: 'cairo', color: lightGreen),
                              ),
                              onPressed: () {
                                APIs.deleteExam(widget.exam);
                                APIs.deleteExamImage(widget.exam);
                                Navigator.of(dialogContext).pop();
                                Dialogs.showSnackbar(
                                    context, '✔ تم حذف الاختبار');
                              },
                            ),
                            TextButton(
                              child: Text('رجوع',
                                  style: TextStyle(
                                      fontFamily: 'cairo', color: lightGreen)),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * .01),
                    padding: EdgeInsets.all(width * .035),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: width * .001, color: Colors.red),
                        borderRadius: BorderRadius.circular(width * .05)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ))
        ],
      ),
    );
  }
}