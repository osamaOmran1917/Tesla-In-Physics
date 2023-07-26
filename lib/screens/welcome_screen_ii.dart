import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/screens/auth/login_screen.dart';

class WelcomeScreenII extends StatefulWidget {
  @override
  State<WelcomeScreenII> createState() => _WelcomeScreenIIState();
}

class _WelcomeScreenIIState extends State<WelcomeScreenII> {
  /*var formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  bool studentChecked = false;
  bool oneChecked = false;
  bool twoChecked = false;
  bool threeChecked = false;
  bool parentChecked = false;
  String studentId = '';*/

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
              image: AssetImage('assets/images/wallpaper_ii.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginScreen())),
          child: Image.asset('assets/images/floating.png'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        /*appBar: AppBar(
          backgroundColor: Color(0xff39A552),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
          title: Text(
            'مرحباً بكم',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MyArabicFont',
            ),
          ),
          centerTitle: true,
        ),*/
        /*body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height * .05,
                ),
                Text(
                  'مستخدم الحساب طالب أم ولي أمر؟',
                  style: TextStyle(
                      fontFamily: 'MyArabicFont', fontSize: width * .05),
                ),
                SizedBox(
                  height: height * .07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: studentChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          studentChecked = true;
                          parentChecked = false;
                        });
                      },
                      shape: CircleBorder(),
                      activeColor: Color(0xff39A552),
                    ),
                    Text(
                      'طالب',
                      style: TextStyle(
                          fontFamily: 'MyArabicFont', fontSize: width * .07),
                    )
                  ],
                ),
                if (studentChecked)
                  Text(
                    'اختر الصف',
                    style: TextStyle(
                        fontFamily: 'MyArabicFont', fontSize: width * .065),
                  ),
                if (studentChecked)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: oneChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            oneChecked = true;
                            twoChecked = false;
                            threeChecked = false;
                          });
                        },
                        activeColor: Color(0xff39A552),
                      ),
                      Text(
                        'الأول',
                        style: TextStyle(
                            fontFamily: 'MyArabicFont', fontSize: width * .05),
                      )
                    ],
                  ),
                if (studentChecked)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: twoChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            twoChecked = true;
                            oneChecked = false;
                            threeChecked = false;
                          });
                        },
                        activeColor: Color(0xff39A552),
                      ),
                      Text(
                        'الثاني',
                        style: TextStyle(
                            fontFamily: 'MyArabicFont', fontSize: width * .05),
                      )
                    ],
                  ),
                if (studentChecked)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: threeChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            threeChecked = true;
                            oneChecked = false;
                            twoChecked = false;
                          });
                        },
                        activeColor: Color(0xff39A552),
                      ),
                      Text(
                        'الثالث',
                        style: TextStyle(
                            fontFamily: 'MyArabicFont', fontSize: width * .05),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: parentChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          studentChecked = false;
                          parentChecked = true;
                          oneChecked = false;
                          twoChecked = false;
                          threeChecked = false;
                        });
                      },
                      shape: CircleBorder(),
                      activeColor: Color(0xff39A552),
                    ),
                    Text(
                      'ولي أمر',
                      style: TextStyle(
                          fontFamily: 'MyArabicFont', fontSize: width * .07),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .09,
                ),
                Visibility(
                  visible: parentChecked,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'بجب إدخال رمز';
                        }
                        return null;
                      },
                      maxLines: null,
                      onChanged: (value) => studentId = value,
                      decoration: InputDecoration(
                          label: Text('أدخل رمز الطالب/الطالبة'),
                          hintText: 'رمز الطالب/الطالبة',
                          prefixIcon: Icon(
                            CupertinoIcons.mail_solid,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .09,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: (studentChecked || parentChecked)
                            ? Color.fromARGB(255, 219, 255, 178)
                            : Colors.grey,
                        shape: StadiumBorder(),
                        elevation: 1),
                    onPressed: () async {
                      if (formKey.currentState?.validate() == false) {
                        return;
                      } else {
                        if (studentChecked) {
                          if (oneChecked) APIs.updateLevel(APIs.user.uid, 1);
                          if (twoChecked) APIs.updateLevel(APIs.user.uid, 2);
                          if (threeChecked) APIs.updateLevel(APIs.user.uid, 3);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomeScreen()));
                        } else {
                          if (studentId.isNotEmpty) {
                            APIs.setAsParent(APIs.user.uid);
                            await APIs.setStudentAsSon(studentId).then((value) {
                              if (!value) {
                                Dialogs.showSnackbar(context,
                                    'There is no users with this e-mail');
                                return;
                              } else {
                                APIs.updateStudentId(APIs.user.uid, studentId);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => HomeScreen()));
                              }
                            });
                          }
                        }
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * .09,
                            fontFamily: 'MyArabicFont',
                          ),
                          children: [
                            TextSpan(text: 'استمرار'),
                          ]),
                    ))
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}
