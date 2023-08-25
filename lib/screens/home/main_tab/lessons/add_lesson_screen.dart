import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/models/lesson.dart';
import 'package:omar_mostafa/screens/home/main_tab/lessons/lessons_screen.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? _controller;
  String? video;
  int contentLength = 0;
  List<TextEditingController> contentControllers = [];

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _controller = VideoPlayerController.file(File(pickedFile.path))
        ..initialize().then((_) {
          setState(() {
            _controller!.play();
            video = pickedFile.path;
          });
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
                for (int i = 0; i < contentControllers.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: height * .05),
                    child: TextField(
                      controller: contentControllers[i],
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  contentControllers
                                      .remove(contentControllers[i]);
                                });
                              },
                              child: Icon(
                                CupertinoIcons.minus,
                                color: lightGreen,
                              )),
                          labelText: 'المحتوى',
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
                  ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        contentControllers.add(TextEditingController());
                      });
                    },
                    child: Text(
                      'أضف محتوى+',
                      style: TextStyle(fontFamily: 'cairo', color: lightGreen),
                    )),
                SizedBox(
                  height: height * .05,
                ),
                ElevatedButton.icon(
                  onPressed: _pickVideo,
                  icon: Icon(
                    CupertinoIcons.videocam_circle,
                    size: 25,
                  ),
                  label: Text(
                    _controller == null ? 'أضف فيديو' : 'تغيير الفيديو',
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
                if (_controller != null && _controller!.value.isInitialized)
                  AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: darkGreen),
              onPressed: () async {
                List<String> content = contentControllers
                    .map((controller) => controller.text)
                    .toList();
                if (level != null &&
                    titleController.text.trim().isNotEmpty &&
                    numController.text.trim().isNotEmpty) {
                  Dialogs.showProgressBar(context);
                  Lesson lesson = new Lesson(
                      name: titleController.text.toString() ?? '',
                      details: detailsController.text.toString() ?? '',
                      level: level ?? 0,
                      content: content ?? [],
                      number: numController.text == '1'
                          ? 'الدرس الأول'
                          : numController.text == '2'
                              ? 'الدرس الثاني'
                              : numController.text == '3'
                                  ? 'الدرس الثالث'
                          : numController.text == '4'
                          ? 'الدرس الرابع'
                          : numController.text == '5'
                          ? 'الدرس الخامس'
                          : numController.text == '6'
                          ? 'الدرس السادس'
                          : numController.text == '7'
                          ? 'الدرس السابع'
                          : numController.text == '8'
                          ? 'الدرس الثامن'
                          : numController.text ==
                          '9'
                          ? 'الدرس التاسع'
                          : numController
                          .text ==
                          '10'
                          ? 'الدرس العاشر'
                          : numController
                          .text ==
                          '11'
                          ? 'الدرس الحادي عشر'
                          : numController
                          .text ==
                          '12'
                          ? 'الدرس الثاني عشر'
                          : numController.text ==
                          '13'
                          ? 'الدرس الثالث عشر'
                          : numController.text == '14'
                          ? 'الدرس الرابع عشر'
                          : numController.text == '15'
                          ? 'الدرس الخامس عشر'
                          : numController.text == '6'
                          ? 'الدرس السادس عشر'
                          : numController.text == '17'
                          ? 'الدرس السابع عشر'
                          : numController.text == '18'
                          ? 'الدرس الثامن عشر'
                          : numController.text == '19'
                          ? 'الدرس التاسع عشر'
                          : 'الدرس العشرون');
                  APIs.addLesson(lesson).then((value) =>
                      APIs.addLessonVideo(lesson, File(video ?? '')));
                  List pushTokens = await APIs.getPushTokens(level!);
                  List names = await APIs.getNames(level!);
                  log(names[0]);
                  log(pushTokens[0]);
                  for (int i = 0; i < pushTokens.length; i++) {
                    APIs.sendPushNotification(pushTokens[i], names[i],
                        'قام مستر عمر بنشر درس جديد تابع..');
                  }
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LessonsScreen()));
                  Dialogs.showSnackbar(context, 'تم رفع الدرس بنجاح ✔');
                  print(numController.text.toString());
                } else {
                  Dialogs.showSnackbar(
                      context, 'يجب إدخال مرحلة دراسية و عنوان و رقم للدرس!');
                }
              },
              child: Text(
                'نشر',
                style: TextStyle(fontFamily: 'Cairo', fontSize: width * .05),
              )),
        ));
  }

  Future pickVideo() async {
    ImagePicker().pickVideo(source: ImageSource.gallery);
  }
}
