import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/screens/home/profile_tab/exams/add_exams_marks.dart';
import 'package:omar_mostafa/widgets/exam_widget.dart';

class ShowExamsMarks extends StatelessWidget {
  int level;

  ShowExamsMarks(this.level, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/designed_background.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .067,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(width * .039),
                  decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: const Icon(
                    Icons.keyboard_arrow_left_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    level == 1
                        ? 'اختبارات الصف الأول'
                        : level == 2
                            ? 'اختبارات الصف الثاني'
                            : 'اختبارات الصف الثالث',
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontSize: width * .05,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: height * .045,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Exam>>(
                  builder: (buildContext, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('خطأ في تحميل البيانات حاول لاحقا'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: lightGreen),
                      );
                    }
                    var data =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        return data.isEmpty
                            ? const Center(
                                child: Text('لم يتم رفع أي امتحانات حتى الآن.'),
                              )
                            : ExamWidget(data[index]);
                      },
                      itemCount: data!.length,
                    );
                  },
                  stream:
                      APIs.ListenForExamsRealTimeUpdatesDependingOnLevel(level),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: lightGreen,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => AddExamsMarks(level)));
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
    );
  }
}