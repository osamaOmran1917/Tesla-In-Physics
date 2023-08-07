import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/my_user.dart';
import 'package:omar_mostafa/widgets/user_card.dart';

class SetAttendance extends StatefulWidget {
  int level, month, lec;

  SetAttendance(this.level, this.month, this.lec);

  @override
  State<SetAttendance> createState() => _SetAttendanceState();
}

class _SetAttendanceState extends State<SetAttendance> {
  @override
  Widget build(BuildContext context) {
    String levelText = widget.level == 1
        ? 'الأول'
        : widget.level == 2
            ? 'الثاني'
            : 'الثالث';
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
                      'الصف $levelText شهر ${widget.month} الحصة ${widget.lec}',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: width * .05,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot<MyUser>>(
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
                                  child: Text('لا يوجد تغييرات'),
                                )
                              : UserCard(data[index]);
                        },
                        itemCount: data!.length,
                      );
                    },
                    stream:
                        APIs.ListenForStudentsRealTimeUpdatesDependingOnLevel(
                            widget.level),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
