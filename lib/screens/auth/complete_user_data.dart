import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/screens/home_screen.dart';

class CompleteUserData extends StatefulWidget {
  bool is_student;

  CompleteUserData(this.is_student);

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
      APIs.setAsParent(APIs.user.uid);
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
    int? level;
    bool? male;
    return Container(
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
                        Image.asset('assets/images/back.png'),
                      ],
                    ),
                    Text(
                      'أكمل بياناتك',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                    Text(
                      'الرجاء تكملة البيانات كاملة لنبدأ التعلم',
                      style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
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
                              borderRadius: BorderRadius.circular(width * .039),
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
                                  if (value == '1') {
                                    level = 1;
                                  } else if (value == '2') {
                                    level = 2;
                                  } else {
                                    level = 3;
                                  }
                                },
                                icon: Row(
                                  children: [
                                    ImageIcon(
                                        AssetImage('assets/images/down.png')),
                                    Expanded(child: Container()),
                                    Text(
                                      'اختر مرحلة دراسية',
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
                          )
                        : Container(
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
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
                          widget.is_student ? 'النوع' : 'المرحلة الدراسية',
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
                              borderRadius: BorderRadius.circular(width * .039),
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
                                    male = true;
                                  } else {
                                    male = false;
                                  }
                                },
                                icon: Row(
                                  children: [
                                    ImageIcon(
                                        AssetImage('assets/images/down.png')),
                                    Expanded(child: Container()),
                                    Text(
                                      'اختر النوع',
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
                        : Container(
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == '1') {
                                    level = 1;
                                  } else if (value == '2') {
                                    level = 2;
                                  } else {
                                    level = 3;
                                  }
                                },
                                icon: Row(
                                  children: [
                                    ImageIcon(
                                        AssetImage('assets/images/down.png')),
                                    Expanded(child: Container()),
                                    Text(
                                      'اختر مرحلة دراسية',
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
                      height: height * .09,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState?.validate() == false ||
                            level == null ||
                            male == null) {
                          Dialogs.showSnackbar(
                              context, 'يجب ملأ جميع البيانات');
                          return;
                        }
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
                                    fontFamily: 'cairo', color: Colors.white))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
