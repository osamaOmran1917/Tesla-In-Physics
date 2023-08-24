import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omar_mostafa/helpers/colors.dart';

class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({super.key});

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  var titleController = TextEditingController();

  var detailsController = TextEditingController();

  var numController = TextEditingController();
  int? level;
  String? _video;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
        padding: EdgeInsets.all(width * .05),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/designed_background.jpg'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height * .05,
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: 'العنوان',
                      labelStyle: TextStyle(fontFamily: 'Cairo'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * .05),
                      ),
                      fillColor: lightGreen,
                      focusColor: lightGreen,
                      hoverColor: lightGreen,
                      iconColor: lightGreen,
                      prefixIconColor: lightGreen,
                      suffixIconColor: lightGreen,
                      hintStyle: TextStyle(color: lightGreen)),
                  style: TextStyle(color: lightGreen, fontFamily: 'cairo'),
                  cursorColor: lightGreen,
                ),
                SizedBox(
                  height: height * .05,
                ),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(
                      labelText: 'التفاصيل',
                      labelStyle: TextStyle(fontFamily: 'Cairo'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * .05),
                      ),
                      fillColor: lightGreen,
                      focusColor: lightGreen,
                      hoverColor: lightGreen,
                      iconColor: lightGreen,
                      prefixIconColor: lightGreen,
                      suffixIconColor: lightGreen,
                      hintStyle: TextStyle(color: lightGreen)),
                  style: TextStyle(color: lightGreen, fontFamily: 'cairo'),
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
                    borderRadius: BorderRadius.circular(width * .043),
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
                          ImageIcon(AssetImage('assets/images/down.png')),
                          Expanded(child: Container()),
                          Text(
                            level == null
                                ? 'اختر مرحلة دراسية'
                                : level.toString(),
                            style: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
                          )
                        ],
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('1'),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text('2'),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text('3'),
                              value: 3,
                            ),
                          ]),
                ),
                SizedBox(
                  height: height * .05,
                ),
                TextField(
                  controller: numController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: InputDecoration(
                      counterText: '',
                      labelText: 'رقم الدرس',
                      labelStyle: TextStyle(fontFamily: 'Cairo'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * .05),
                      ),
                      fillColor: lightGreen,
                      focusColor: lightGreen,
                      hoverColor: lightGreen,
                      iconColor: lightGreen,
                      prefixIconColor: lightGreen,
                      suffixIconColor: lightGreen,
                      hintStyle: TextStyle(color: lightGreen)),
                  style: TextStyle(color: lightGreen, fontFamily: 'cairo'),
                  cursorColor: lightGreen,
                ),
                SizedBox(
                  height: height * .05,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showBottomSheet();
                  },
                  icon: Icon(
                    CupertinoIcons.videocam_circle,
                    size: 25,
                  ),
                  label: Text(
                    'أضف فيديو',
                    style: TextStyle(fontSize: 16, fontFamily: 'Arabic'),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: lightGreen,
                      shape: StadiumBorder(),
                      minimumSize: Size(MediaQuery.of(context).size.width * .5,
                          MediaQuery.of(context).size.height * .06)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                _video != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .1),
                        child: Image.file(
                          File(_video!),
                          width: MediaQuery.of(context).size.height * .2,
                          height: MediaQuery.of(context).size.height * .2,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 0,
                        width: 0,
                      ),
                if (_video != null)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
              ],
            ),
          ),
          bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: darkGreen),
              onPressed: () async {
                /*if (level != null) {
                    Post post = new Post(
                        title:
                        titleController.text.toString(),
                        details:
                        detailsController.text.toString(),
                        textDate:
                        numController.text.toString(),
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
                    print(numController.text.toString());
                  } else {
                    Dialogs.showSnackbar(
                        context, 'يجب إدخال مرحلة دراسية!');
                    Navigator.pop(context);
                  }*/
              },
              child: Text(
                'نشر',
                style: TextStyle(fontFamily: 'Cairo', fontSize: width * .05),
              )),
        ));
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .02,
                bottom: MediaQuery.of(context).size.height * .05),
            children: [
              Text(
                'اختر مقطعاً',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Arabic'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: CircleBorder(),
                      fixedSize: Size(MediaQuery.of(context).size.width * .3,
                          MediaQuery.of(context).size.height * .15)),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image
                    final XFile? image =
                        await picker.pickVideo(source: ImageSource.gallery);
                    if (image != null) {
                      log('Video path: ${image.path} -- MimeType ${image.mimeType}');
                      setState(() {
                        _video = image.path;
                        print(
                            ' أهيييييييييييييييي  ************************** الفيديو$_video');
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset('assets/images/video.png'))
            ],
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))));
  }
}
