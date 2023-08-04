import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';

class UsereProfileScreen extends StatefulWidget {
  @override
  State<UsereProfileScreen> createState() => _UsereProfileScreenState();
}

class _UsereProfileScreenState extends State<UsereProfileScreen> {
  String name = '';
  String image = '';
  String email = '';
  bool _is_student = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool? male;
  String? _picked_image;

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
    setState(() {
      name = data!['name'];
      image = data['image'];
      email = data['email'];
      _is_student = data['is_student'];
    });
  }

  int? level;

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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .061),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .067,
                    width: double.infinity,
                  ),
                  Row(
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
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'تعديل البيانات',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: width * .05),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  Stack(
                    children: [
                      _picked_image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(height * .1),
                              child: Image.file(
                                File(_picked_image!),
                                width: height * .15,
                                height: height * .15,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(height * .1),
                              child: CachedNetworkImage(
                                width: height * .15,
                                height: height * .15,
                                imageUrl: image,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  child: Icon(CupertinoIcons.person_alt),
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .021,
                              vertical: height * .007),
                          minWidth: 0,
                          height: 30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * .03),
                          ),
                          onPressed: () {
                            _showBottomSheet(context);
                          },
                          child: Icon(
                            CupertinoIcons.pen,
                            color: Colors.white,
                          ),
                          color: lightGreen,
                        ),
                      )
                    ],
                  ),
                  Text(
                    email,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: width * .041,
                        fontWeight: FontWeight.bold),
                  ),
                  Visibility(
                    visible: (!omar) && _is_student,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'المرحلة الدراسية',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (!omar) && _is_student,
                    child: SizedBox(
                      height: height * .013,
                    ),
                  ),
                  Visibility(
                    visible: (!omar) && _is_student,
                    child: Container(
                      height: height * .07,
                      width: width * .85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * .039),
                        boxShadow: [
                          BoxShadow(
                            color: lightGreen.withOpacity(0.17),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
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
                                    ? 'اختر مرحلتك الدراسية'
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الاسم',
                        style: TextStyle(
                            fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .013,
                  ),
                  Container(
                    height: height * .07,
                    width: width * .85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .039),
                      boxShadow: [
                        BoxShadow(
                          color: lightGreen.withOpacity(0.17),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'يجب إدخال اسم';
                        }
                        return null;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'اكتب اسمك كامل',
                        hintStyle:
                        TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: width * .03),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'الهاتف',
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .013,
                  ),
                  Container(
                    height: height * .07,
                    width: width * .85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * .039),
                      boxShadow: [
                        BoxShadow(
                          color: lightGreen.withOpacity(0.17),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      controller: phoneController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'يجب إدخال رقم هاتف';
                        }
                        return null;
                      },
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'اكتب رقم هاتفك',
                        hintStyle:
                        TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: width * .03),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (!omar) && _is_student,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'النوع',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * .013,
                        ),
                        Container(
                          height: height * .07,
                          width: width * .85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * .039),
                            boxShadow: [
                              BoxShadow(
                                color: lightGreen.withOpacity(0.17),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: PopupMenuButton(
                              onSelected: (value) {
                                if (value == true) {
                                  setState(() {
                                    male = true;
                                  });
                                } else {
                                  setState(() {
                                    male = false;
                                  });
                                }
                              },
                              icon: Row(
                                children: [
                                  ImageIcon(
                                      AssetImage('assets/images/down.png')),
                                  Expanded(child: Container()),
                                  Text(
                                    male == null
                                        ? 'اختر النوع'
                                        : male == true
                                        ? 'ذكر'
                                        : 'أنثى',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text('ذكر'),
                                  value: true,
                                ),
                                PopupMenuItem(
                                  child: Text('أنثى'),
                                  value: false,
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  InkWell(
                    onTap: () {
                      if ((!omar) && _is_student) {
                        if (level != null)
                          APIs.updateLevel(APIs.user.uid, level!);
                        if (male != null)
                          APIs.updateGender(APIs.user.uid, male!);
                      }
                      if (nameController.text.isNotEmpty &&
                          nameController.text != null)
                        APIs.updateName(APIs.user.uid, nameController.text);
                      if (phoneController.text.isNotEmpty &&
                          phoneController.text != null)
                        APIs.updatePhone(APIs.user.uid, phoneController.text);
                      if (level == null &&
                          male == null &&
                          nameController.text.isEmpty &&
                          phoneController.text.isEmpty) {
                        Dialogs.showSnackbar(context, 'لم يتم تغيير شيئ');
                      } else {
                        Dialogs.showSnackbar(context, 'تم حفظ التغييرات بنجاح');
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .23, vertical: height * .01),
                        decoration: BoxDecoration(
                            color: lightGreen,
                            borderRadius: BorderRadius.circular(width * .03)),
                        child: Text(
                          'حفظ التغييرات',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Cairo'),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * .05),
                topRight: Radius.circular(width * .05))),
        context: context,
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: height * .03, bottom: height * .05),
            children: [
              Text(
                'اختر صورة شخصية',
                style: TextStyle(fontFamily: 'Cairo'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(width * .3, height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path} -- MimeType: ${image.mimeType}');
                          setState(() {
                            _picked_image = image.path;
                          });
                          APIs.updateProfilePicture(File(_picked_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/gallery.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: CircleBorder(),
                          fixedSize: Size(width * .3, height * .15)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() {
                            _picked_image = image.path;
                          });
                          APIs.updateProfilePicture(File(_picked_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('assets/images/camera.png'))
                ],
              )
            ],
          );
        });
  }
}
