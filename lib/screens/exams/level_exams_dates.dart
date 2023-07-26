import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/screens/exams/add_exam_bottom_sheet.dart';
import 'package:omar_mostafa/widgets/exam_date_card.dart';

class LevelExamsDate extends StatefulWidget {
  int level;

  LevelExamsDate(this.level);

  @override
  State<LevelExamsDate> createState() => _LevelExamsDateState();
}

class _LevelExamsDateState extends State<LevelExamsDate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Exam>>(
      builder: (buildContext, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('خطأ في تحميل البيانات، حاول لاحقا.'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        }
        var data = snapshot.data?.docs.map((e) => e.data()).toList();
        all = data ?? [];
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff39A552),
            onPressed: () => showAddExamButtomSheet(),
            child: Icon(CupertinoIcons.add),
          ),
          body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (buildContext, index) {
              return data.isEmpty
                  ? Center(
                      child: Text(
                        'لا يوجد امتحانات',
                        style: TextStyle(fontFamily: 'MyArabicFont'),
                      ),
                    )
                  : InkWell(
                      child: ExamDateCard(
                      exam: data[index],
                    ));
            },
            itemCount: data!.length,
          ),
        );
      },
      // future: MyDataBase.getAllMissingPersons(),
      stream: APIs.listenForExamsRealTimeUpdates(widget.level),
    );
  }

  void showAddExamButtomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return AddExamBottomSheet(widget.level);
        });
  }

  DateTime selectedDate = DateTime.now();

}

late List<Exam> all;
