import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/lesson.dart';
import 'package:omar_mostafa/models/post.dart';
import 'package:omar_mostafa/provider/sign_in_provider.dart';
import 'package:omar_mostafa/screens/home/main_tab/latest_changes.dart';
import 'package:omar_mostafa/screens/home/main_tab/lessons/lesson_details.dart';
import 'package:omar_mostafa/screens/home/main_tab/lessons/lessons_screen.dart';
import 'package:omar_mostafa/widgets/lesson_widget.dart';
import 'package:omar_mostafa/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class MainTab extends StatefulWidget {
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  String name = '';
  String image = '';
  int userLevel = 0;
  bool paid = false;

  String? nameSp;

  @override
  void initState() {
    super.initState();
    getName();
    _getFieldValue();
  }

  Future<void> _getFieldValue() async {
    final idSp = SherdHelper.getData(key: "id");
    log(idSp.toString());
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(idSp ?? APIs.user.uid)
        .get();
    var data = documentSnapshot.data();
    setState(() {
      name = data!['name'];
      image = data['image'];
    });

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

  Future<void> getName() async {
    setState(() {
      nameSp = SherdHelper.getData(key: "name");
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    final sp = context.read<SignInProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .05),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: height * .065,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    log(name);
                  },
                  child: Container(
                    padding: EdgeInsets.all(width * .039),
                    decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(width * .05)),
                    child: Image.asset(
                      'assets/images/Notification.png',
                      width: width * .061,
                      height: width * .061,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'مرحبا ${name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                    Text(
                      omar
                          ? 'تحكم في كل شيء يخص تطبيقك'
                          : '🤝🏻 !لنبدأ رحلة التعلم',
                      style: TextStyle(fontFamily: 'Cairo'),
                    )
                  ],
                ),
                SizedBox(
                  width: width * .05,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(height * .015),
                  child: CachedNetworkImage(
                    width: height * .055,
                    height: height * .055,
                    imageUrl: image ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person_alt)),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                print(sp.uid);
              },
              child: Image.asset(
                'assets/images/offer.png',
                height: height * .3,
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LessonsScreen())),
                  child: Text(
                    'عرض الكل',
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  'الدروس',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: width * .05),
                )
              ],
            ),
            Container(
              height: height * .3,
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
                  var data = snapshot.data?.docs.map((e) => e.data()).toList();
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (buildContext, index) {
                      return data.isEmpty
                          ? Center(
                        child: Text(
                                'لا يوجد دروس حتى الآن',
                                style: TextStyle(color: Colors.black),
                              ),
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
                    ? APIs.ListenForFirstTwoLessonsRealTimeUpdates()
                    : APIs.ListenForLevelFirstTwoLessonsRealTimeUpdates(
                        userLevel),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LatestChanges())),
                  child: Text(
                    'عرض الكل',
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  'أحدث التغيرات',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: width * .05),
                )
              ],
            ),
            Container(
              height: height * .3,
              child: StreamBuilder<QuerySnapshot<Post>>(
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
                  var data = snapshot.data?.docs.map((e) => e.data()).toList();
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (buildContext, index) {
                      return data.isEmpty
                          ? Center(
                              child: Text('لا يوجد تغيرات'),
                            )
                          : PostWidget(data[index]);
                    },
                    itemCount: data!.length,
                  );
                },
                // future: MyDataBase.getAllMissingPersons(),
                stream: omar
                    ? APIs.getFirstTwoPostsForOmar()
                    : APIs.getFirstTwoPosts(userLevel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
