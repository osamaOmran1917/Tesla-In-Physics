import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/post.dart';
import 'package:omar_mostafa/widgets/post_widget.dart';

class LatestChanges extends StatefulWidget {
  const LatestChanges({super.key});

  @override
  State<LatestChanges> createState() => _LatestChangesState();
}

class _LatestChangesState extends State<LatestChanges> {
  var titleController = TextEditingController();

  var detailsController = TextEditingController();

  var dateController = TextEditingController();

  int? level;

  int userLevel = 0;

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
    if (data!['is_student'] == true) {
      setState(() {
        userLevel = data['level'];
      });
    } else {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(data['student_id'])
          .get();
      var newData = documentSnapshot.data();
      setState(() {
        userLevel = newData!['level'];
      });
    }
  }

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
                'أحدث التغيرات',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: width * .05),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Post>>(
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
                                child: Text('لا يوجد تغييرات'),
                              )
                            : InkWell(
                                onTap: () {}, child: PostWidget(data[index]));
                      },
                      itemCount: data!.length,
                    );
                  },
                  // future: MyDataBase.getAllMissingPersons(),
                  stream: omar
                      ? APIs.ListenForPostsRealTimeUpdates()
                      : APIs.ListenForLevelPostsRealTimeUpdates(userLevel),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: omar
            ? FloatingActionButton(
          backgroundColor: lightGreen,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return Padding(
                    padding: EdgeInsets.all(width * .05),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .05,
                        ),
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                              labelText: 'العنوان',
                                    labelStyle:
                                        const TextStyle(fontFamily: 'Cairo'),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * .05),
                                    ),
                                    fillColor: lightGreen,
                                    focusColor: lightGreen,
                                    hoverColor: lightGreen,
                                    iconColor: lightGreen,
                                    prefixIconColor: lightGreen,
                                    suffixIconColor: lightGreen,
                                    hintStyle:
                                        const TextStyle(color: lightGreen)),
                                style: const TextStyle(
                                    color: lightGreen, fontFamily: 'cairo'),
                                cursorColor: lightGreen,
                              ),
                        SizedBox(
                          height: height * .05,
                        ),
                        TextField(
                          controller: detailsController,
                          decoration: InputDecoration(
                              labelText: 'التفاصيل',
                                    labelStyle:
                                        const TextStyle(fontFamily: 'Cairo'),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * .05),
                                    ),
                                    fillColor: lightGreen,
                                    focusColor: lightGreen,
                                    hoverColor: lightGreen,
                                    iconColor: lightGreen,
                                    prefixIconColor: lightGreen,
                                    suffixIconColor: lightGreen,
                                    hintStyle:
                                        const TextStyle(color: lightGreen)),
                                style: const TextStyle(
                                    color: lightGreen, fontFamily: 'cairo'),
                                cursorColor: lightGreen,
                              ),
                        SizedBox(
                          height: height * .05,
                        ),
                        Container(
                          height: height * .07,
                          width: width * .85,
                          decoration: BoxDecoration(
                            border: Border.all(width: width * .001),
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(width * .043),
                          ),
                          child: PopupMenuButton(
                              onSelected: (value) {
                                if (value == 1) {
                                  setState(() {
                                    level = 1;
                                  });
                                } else if (value == 2) {
                                  setState(() {
                                    level = 2;
                                  });
                                } else {
                                  setState(() {
                                    level = 3;
                                  });
                                }
                              },
                              icon: Row(
                                children: [
                                  const ImageIcon(AssetImage(
                                            'assets/images/down.png')),
                                  Expanded(child: Container()),
                                  Text(
                                    level == null
                                        ? 'اختر مرحلة دراسية'
                                        : level.toString(),
                                    style: const TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.grey),
                                  )
                                ],
                              ),
                              shape: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                            value: 1,
                                            child: Text('1'),
                                          ),
                                const PopupMenuItem(
                                            value: 2,
                                            child: Text('2'),
                                          ),
                                const PopupMenuItem(
                                            value: 3,
                                            child: Text('3'),
                                          ),
                              ]),
                        ),
                        SizedBox(
                          height: height * .05,
                        ),
                        TextField(
                          controller: dateController,
                          decoration: InputDecoration(
                              labelText: 'يمكنك إضافة موعد',
                                    labelStyle:
                                        const TextStyle(fontFamily: 'Cairo'),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(width * .05),
                                    ),
                                    fillColor: lightGreen,
                                    focusColor: lightGreen,
                                    hoverColor: lightGreen,
                                    iconColor: lightGreen,
                                    prefixIconColor: lightGreen,
                                    suffixIconColor: lightGreen,
                                    hintStyle:
                                        const TextStyle(color: lightGreen)),
                                style: const TextStyle(
                                    color: lightGreen, fontFamily: 'cairo'),
                                cursorColor: lightGreen,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: lightGreen),
                                  onPressed: () async {
                                    if (level != null) {
                                      Post post = Post(
                                          title:
                                              titleController.text.toString(),
                                          details:
                                              detailsController.text.toString(),
                                          textDate:
                                              dateController.text.toString(),
                                          level: level);
                                      APIs.addPost(post);
                                      List pushTokens =
                                          await APIs.getPushTokens(level!);
                                      List names = await APIs.getNames(level!);
                                      log(names[0]);
                                      log(pushTokens[0]);
                                      for (int i = 0;
                                          i < pushTokens.length;
                                          i++) {
                                        APIs.sendPushNotification(
                                            pushTokens[i],
                                            names[i],
                                            'قام مستر عمر بنشر تحديث جديد تابع..');
                                      }
                                      Navigator.pop(context);
                                      print(dateController.text.toString());
                                    } else {
                                      Dialogs.showSnackbar(
                                          context, 'يجب إدخال مرحلة دراسية!');
                                      Navigator.pop(context);
                                    }
                                  },
                            child: Text(
                              'نشر',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: width * .05),
                            ))
                      ],
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width * .1),
                        topLeft: Radius.circular(width * .1))));
          },
          child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
        )
            : null,
      ),
    );
  }
}