import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/provider/sign_in_provider.dart';
import 'package:omar_mostafa/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class CompleteUserData extends StatefulWidget {
  bool is_student;
  bool is_phone;

  CompleteUserData(this.is_student, this.is_phone);

  @override
  State<CompleteUserData> createState() => _CompleteUserDataState();
}

class _CompleteUserDataState extends State<CompleteUserData> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.is_student == false) {
      final idSp = SherdHelper.getData(key: "id");
      log(idSp.toString());
      APIs.setAsParent(idSp ?? APIs.user.uid);
    }
  }

  int? level;
  bool? male;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    final sp = context.read<SignInProvider>();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
      onWillPop: () async {
        APIs.deleteUser();
        await GoogleSignIn().disconnect();
        await APIs.auth.signOut();
        await GoogleSignIn().signOut();
        return true;
      },
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/designed_background.jpg'))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .065, vertical: height * .07),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                APIs.deleteUser();
                                await GoogleSignIn().disconnect();
                                await APIs.auth.signOut();
                                await GoogleSignIn().signOut();
                                Navigator.pop(context);
                              },
                              child: Image.asset('assets/images/back.png')),
                        ],
                      ),
                      Text(
                        'أكمل بياناتك',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                      ),
                      Text(
                        'الرجاء تكملة البيانات كاملة لنبدأ التعلم',
                        style:
                            TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.is_student == true
                                ? 'المرحلة الدراسية'
                                : 'الاسم',
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .013,
                      ),
                      widget.is_student
                          ? Container(
                              height: height * .07,
                              width: width * .85,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(width * .039),
                                boxShadow: [
                                  BoxShadow(
                                    color: lightGreen.withOpacity(0.17),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
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
                                      ImageIcon(
                                          AssetImage('assets/images/down.png')),
                                      Expanded(child: Container()),
                                      Text(
                                        level == null
                                            ? 'اختر مرحلة دراسية'
                                            : level.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  shape: OutlineInputBorder(
                                      borderSide: BorderSide(color: lightGreen),
                                      borderRadius: BorderRadius.circular(10)),
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text(
                                            '1',
                                            style:
                                                TextStyle(fontFamily: 'cairo'),
                                          ),
                                          value: 1,
                                        ),
                                        PopupMenuItem(
                                          child: Text('2',
                                              style: TextStyle(
                                                  fontFamily: 'cairo')),
                                          value: 2,
                                        ),
                                        PopupMenuItem(
                                          child: Text('3',
                                              style: TextStyle(
                                                  fontFamily: 'cairo')),
                                          value: 3,
                                        ),
                                      ]),
                            )
                          : Container(
                              height: height * .07,
                              width: width * .85,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(width * .039),
                                boxShadow: [
                                  BoxShadow(
                                    color: lightGreen.withOpacity(0.17),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                style: TextStyle(fontFamily: 'cairo'),
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
                                  hintStyle: TextStyle(
                                      fontFamily: 'Cairo', color: Colors.grey),
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
                            widget.is_student == true ? 'الاسم' : 'رمز الطالب',
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
                        child: TextFormField(
                          style: TextStyle(fontFamily: 'cairo'),
                          controller:
                              widget.is_student ? nameController : idController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return widget.is_student
                                  ? 'يجب إدخال اسم'
                                  : 'يجب إدخال رمز الطالب';
                            }
                            return null;
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.is_student
                                ? 'اكتب اسمك كامل'
                                : 'اكتب رمز الطالب',
                            hintStyle: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: width * .03),
                          ),
                        ),
                      ),
                      if (widget.is_phone == false)
                        SizedBox(
                          height: height * .03,
                        ),
                      if (widget.is_phone == false)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'الهاتف',
                              style: TextStyle(fontFamily: 'Cairo'),
                            ),
                          ],
                        ),
                      if (widget.is_phone == false)
                        SizedBox(
                          height: height * .013,
                        ),
                      if (widget.is_phone == false)
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
                          child: TextFormField(
                            style: TextStyle(fontFamily: 'cairo'),
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
                              counterText: '',
                              border: InputBorder.none,
                              hintText: 'اكتب رقم هاتفك',
                              hintStyle: TextStyle(
                                  fontFamily: 'Cairo', color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: width * .03),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: height * .03,
                      ),
                      Visibility(
                        visible: widget.is_student,
                        child: Column(
                          children: [
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
                                borderRadius:
                                    BorderRadius.circular(width * .039),
                                boxShadow: [
                                  BoxShadow(
                                    color: lightGreen.withOpacity(0.17),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
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
                                      borderSide: BorderSide(color: lightGreen),
                                      borderRadius: BorderRadius.circular(10)),
                                  itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Text('ذكر',
                                              style: TextStyle(
                                                  fontFamily: 'cairo')),
                                          value: true,
                                        ),
                                        PopupMenuItem(
                                          child: Text('أنثى',
                                              style: TextStyle(
                                                  fontFamily: 'cairo')),
                                          value: false,
                                        )
                                      ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * .09,
                      ),
                      InkWell(
                        onTap: () async {
                          if ((formKey.currentState?.validate() == false ||
                                  level == null ||
                                  male == null) &&
                              widget.is_student == true) {
                            Dialogs.showSnackbar(
                                context, 'يجب ملأ جميع البيانات');
                            return;
                          }
                          if ((formKey.currentState?.validate() == false) &&
                              widget.is_student == false) {
                            Dialogs.showSnackbar(
                                context, 'يجب ملأ جميع البيانات');
                            return;
                          }
                          if (widget.is_student == true) {
                            APIs.updateLevel(APIs.user.uid, level!);
                            APIs.updateName(sp.uid ?? APIs.user.uid,
                                nameController.text.toString());
                            APIs.updatePhone(
                                APIs.user.uid, phoneController.text.toString());
                            APIs.updateGender(APIs.user.uid, male!);
                          } else {
                            if (await APIs.checkStudentExistence(
                                    idController.text.toString()) ==
                                true) {
                              APIs.updateName(APIs.user.uid,
                                  nameController.text.toString());
                              APIs.updatePhone(APIs.user.uid,
                                  phoneController.text.toString());
                              APIs.updateStudentId(
                                  APIs.user.uid, idController.text.toString());
                            } else {
                              Dialogs.showSnackbar(
                                  context, 'لا يوجد طالب بهذا الرمز');
                              return;
                            }
                          }
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        },
                        child: Container(
                          height: height * .05,
                          width: width * .85,
                          decoration: BoxDecoration(
                            color: lightGreen,
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
                          child: Center(
                              child: Text('متابعة',
                                  style: TextStyle(
                                      fontFamily: 'cairo',
                                      color: Colors.white))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
