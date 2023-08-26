import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/lesson.dart';
import 'package:omar_mostafa/screens/home/main_tab/lessons/add_lesson_screen.dart';
import 'package:omar_mostafa/screens/home/main_tab/lessons/lesson_details.dart';
import 'package:omar_mostafa/widgets/lesson_widget.dart';

class LessonsScreen extends StatefulWidget {
  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  int userLevel = 0;
  bool paid = false;

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
    if (data!['is_student'] == true)
      setState(() {
        userLevel = data['level'];
        paid = data['paid'];
      });
    else {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(data['student_id'])
          .get();
      var newData = documentSnapshot.data();
      setState(() {
        userLevel = newData!['level'];
        paid = newData['paid'];
      });
    }
  }

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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .061),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .067,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: Image.asset(
                    'assets/images/back.png',
                    width: width * .15,
                    height: width * .15,
                  ),
                ),
              ),
              Text(
                'الدروس',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: width * .05),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Lesson>>(
                  builder: (buildContext, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('خطأ في تحميل البيانات حاول لاحقا'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: lightGreen),
                      );
                    }
                    var data =
                        snapshot.data?.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        return data.isEmpty
                            ? Center(
                                child: Text('لا يوجد دروس حتى الآن'),
                              )
                            : InkWell(
                                onTap: () {
                                  _getFieldValue();
                                  (paid == true || omar)
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  LessonDetails(data[index])))
                                      : Dialogs.showSnackbar(context,
                                          'غير مسموح لك بمشاهدة الدرس حتى تقوم بدفع الرسوم!');
                                },
                                child: LessonWidget(data[index]));
                      },
                      itemCount: data!.length,
                    );
                  },
                  // future: MyDataBase.getAllMissingPersons(),
                  stream: omar
                      ? APIs.ListenForLessonsRealTimeUpdates()
                      : APIs.ListenForLevelLessonsRealTimeUpdates(userLevel),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: omar
            ? FloatingActionButton(
                backgroundColor: lightGreen,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddLessonScreen()));
                },
                child: Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
