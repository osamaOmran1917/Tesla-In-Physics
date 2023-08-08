import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/screens/home/attendance_tab/months_screen.dart';

class AttendanceTab extends StatefulWidget {
  @override
  State<AttendanceTab> createState() => _AttendanceTabState();
}

class _AttendanceTabState extends State<AttendanceTab> {
  int attendance = 0;
  int absence = 0;

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
        if (DateTime.now().month == 1)
          attendance = data['jan_1'] +
              data['jan_2'] +
              data['jan_3'] +
              data['jan_4'] +
              data['jan_5'] +
              data['jan_6'] +
              data['jan_7'] +
              data['jan_8'] +
              data['jan_9'] +
              data['jan_10'] +
              data['jan_11'] +
              data['jan_12'];
        else if (DateTime.now().month == 2)
          attendance = data['feb_1'] +
              data['feb_2'] +
              data['feb_3'] +
              data['feb_4'] +
              data['feb_5'] +
              data['feb_6'] +
              data['feb_7'] +
              data['feb_8'] +
              data['feb_9'] +
              data['feb_10'] +
              data['feb_11'] +
              data['feb_12'];
        else if (DateTime.now().month == 8)
          attendance = data['aug_1'] +
              data['aug_2'] +
              data['aug_3'] +
              data['aug_4'] +
              data['aug_5'] +
              data['aug_6'] +
              data['aug_7'] +
              data['aug_8'] +
              data['aug_9'] +
              data['aug_10'] +
              data['aug_11'] +
              data['aug_12'];
      });
    else {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(data['student_id'])
          .get();
      var newData = documentSnapshot.data();
      setState(() {
        if (DateTime.now().month == 1)
          attendance = newData!['jan_1'] +
              newData['jan_2'] +
              newData['jan_3'] +
              newData['jan_4'] +
              newData['jan_5'] +
              newData['jan_6'] +
              newData['jan_7'] +
              newData['jan_8'] +
              newData['jan_9'] +
              newData['jan_10'] +
              newData['jan_11'] +
              newData['jan_12'];
        else if (DateTime.now().month == 2)
          attendance = data['feb_1'] +
              newData!['feb_2'] +
              newData['feb_3'] +
              newData['feb_4'] +
              newData['feb_5'] +
              newData['feb_6'] +
              newData['feb_7'] +
              newData['feb_8'] +
              newData['feb_9'] +
              newData['feb_10'] +
              newData['feb_11'] +
              newData['feb_12'];
        else if (DateTime.now().month == 8)
          attendance = data['aug_1'] +
              newData!['aug_2'] +
              newData['aug_3'] +
              newData['aug_4'] +
              newData['aug_5'] +
              newData['aug_6'] +
              newData['aug_7'] +
              newData['aug_8'] +
              newData['aug_9'] +
              newData['aug_10'] +
              newData['aug_11'] +
              newData['aug_12'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return omar
        ? Padding(
            padding: EdgeInsets.only(
                top: height * .121, left: width * .07, right: width * .07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الحضور',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      fontSize: width * .05),
                ),
                SizedBox(
                  height: height * .05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MonthsScreen(1)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * .07),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MonthsScreen(2)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * .07),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MonthsScreen(3)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * .07),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
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
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
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
                top: height * .121, left: width * .07, right: width * .07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الحضور',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      fontSize: width * .05),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'شهر ${DateTime.now().month}',
                      style:
                          TextStyle(fontFamily: 'cairo', fontSize: width * .05),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'عدد مرات الحضور',
                          style: TextStyle(
                              fontFamily: 'Cairo', color: Colors.grey),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          attendance.toString(),
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: width * .07),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: lightGreen,
                          borderRadius: BorderRadius.circular(width * .07)),
                      width: width * .75,
                      height: height * .25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'نسبة حضورك هي',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: width * .05),
                          ),
                          Container(
                            padding: EdgeInsets.all(width * .05),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width * .03),
                                border: Border.all(
                                    width: width * .001, color: Colors.white)),
                            child: Text(
                              '${((attendance / 12) * 100).toStringAsFixed(2)} %',
                              style: TextStyle(
                                  fontFamily: 'cairo', color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
    /*return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: height * .119, width: double.infinity),
          Row(children: [
            SizedBox(
              width: width * .07,
            ),
            Text(
              'المواعيد',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: width * .05),
            ),
          ]),
          SizedBox(height: height * .05),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                Column(
                  children: [
                    Cell(
                      'شفوي',
                      lightGreen,
                      width * .141,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .141),
                  ],
                ),
                Column(
                  children: [
                    Cell(
                      'واجب حصة',
                      lightGreen,
                      width * .241,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .241),
                  ],
                ),
                Column(
                  children: [
                    Cell(
                      'حضور/التاريخ',
                      lightGreen,
                      width * .25,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('', Colors.white, width * .25),
                  ],
                ),
                Column(
                  children: [
                    Cell(
                      'المحاضرة',
                      lightGreen,
                      width * .19,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('الأولى', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('الثانية', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('الثالثة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('الرابعة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('الخامسة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('السادسة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('السابعة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('الثامنة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('التاسعة', Colors.white, width * .19),
                    SizedBox(
                      height: height * .02,
                    ),
                    Cell('العاشرة', Colors.white, width * .19),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
              visible: omar,
              child: SizedBox(
                height: height * .03,
              )),
          Visibility(
            visible: omar,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .05, vertical: height * .003),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * .05),
                border: Border.all(width: width * .003, color: lightGreen),
                boxShadow: [
                  BoxShadow(
                    color: lightGreen.withOpacity(0.17),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                'تحكم في المواعيد',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ),
        ],
      ),
    );*/
  }
}
