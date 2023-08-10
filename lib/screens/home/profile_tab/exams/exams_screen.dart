import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/exam.dart';
import 'package:omar_mostafa/screens/home/profile_tab/exams/show_exams_marks.dart';
import 'package:omar_mostafa/widgets/exam_widget.dart';

class ExamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/designed_background.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: omar
            ? Padding(
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
                  child: Icon(
                    Icons.keyboard_arrow_left_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'الاختبارات',
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowExamsMarks(1)));
                },
                child: Container(
                  padding: EdgeInsets.all(width * .07),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                          Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        'الصف الأول',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .045,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowExamsMarks(2)));
                },
                child: Container(
                  padding: EdgeInsets.all(width * .07),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                          Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        'الصف الثاني',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .045,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShowExamsMarks(3)));
                },
                child: Container(
                  padding: EdgeInsets.all(width * .07),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                          Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        'الصف الثالث',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
            : Padding(
          padding: EdgeInsets.only(
                    top: height * .07, left: width * .07, right: width * .07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(width * .039),
                        decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.circular(width * .05)),
                        child: Icon(
                          Icons.keyboard_arrow_left_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'الاختبارات',
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
                            return Center(
                              child: Text('خطأ في تحميل البيانات حاول لاحقا'),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child:
                                  CircularProgressIndicator(color: lightGreen),
                            );
                          }
                          var data =
                              snapshot.data?.docs.map((e) => e.data()).toList();
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (buildContext, index) {
                              return data.isEmpty
                                  ? Center(
                                      child: Text(
                                          'لم يتم رفع أي امتحانات حتى الآن.'),
                                    )
                                  : ExamWidget(data[index]);
                            },
                            itemCount: data!.length,
                          );
                        },
                        stream: APIs
                            .ListenForExamsRealTimeUpdatesDependingOnStudent(
                                APIs.user.uid),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
