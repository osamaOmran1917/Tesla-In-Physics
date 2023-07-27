import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/screens/auth/complete_user_data.dart';
import 'package:omar_mostafa/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleButtonClick() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
          var retrievedUser = await APIs.getFutureOfUserById(APIs.user.uid);
          SharedData.user = retrievedUser;
        } else {
          await APIs.createUser().then((value) async {
            var retrievedUser = await APIs.getFutureOfUserById(APIs.user.uid);
            SharedData.user = retrievedUser;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CompleteUserData(_isStudent)));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackbar(context, 'حدث خطأ ما!');
      return null;
    }
  }

  bool _isStudent = false;

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
      child: Scaffold(
        /*appBar: AppBar(
          backgroundColor: Color(0xff39A552),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
          title: Text(
            'أ. عُمَرْ مُصْطَفَى',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MyArabicFont',
            ),
          ),
          centerTitle: true,
        ),*/
        backgroundColor: Colors.transparent,
        body: Column(children: [
          SizedBox(width: double.infinity, height: height * .11),
          Image.asset('assets/images/logo.png'),
          SizedBox(height: height * .11),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * .021),
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
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _isStudent = false;
                    });
                  },
                  child: Container(
                    width: width * .39,
                    height: height * .05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .039),
                        color: _isStudent ? Colors.white : darkGreen),
                    child: Center(
                        child: Text('ولي أمر',
                            style: TextStyle(
                                color: _isStudent ? textGrey : Colors.white,
                                fontFamily: 'cairo'))),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isStudent = true;
                    });
                  },
                  child: Container(
                    width: width * .39,
                    height: height * .05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .039),
                        color: _isStudent ? darkGreen : Colors.white),
                    child: Center(
                      child: Text(
                        'طالب',
                        style: TextStyle(
                            color: _isStudent ? Colors.white : textGrey,
                            fontFamily: 'cairo'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: !_isStudent,
              child: Column(
                children: [
                  SizedBox(height: height * .11),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .05),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: lightGreen.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الخاصة بنا',
                          style: TextStyle(
                              fontFamily: 'cairo', fontSize: width * .027),
                        ),
                        SizedBox(
                          width: width * .01,
                        ),
                        Text(
                          'شروط الخدمات و سياسة الخصوصية',
                          style: TextStyle(
                              fontFamily: 'cairo',
                              color: lightGreen,
                              fontSize: width * .027),
                        ),
                        SizedBox(
                          width: width * .01,
                        ),
                        Text(
                          'موافق على',
                          style: TextStyle(
                              fontFamily: 'cairo', fontSize: width * .027),
                        ),
                        SizedBox(
                          width: width * .03,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width),
                              color: lightGreen,
                            ),
                            child: Image.asset(
                              'assets/images/Check.png',
                              width: width * .075,
                            )),
                        SizedBox(
                          width: width * .03,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(height: height * .11),
          InkWell(
            onTap: () {
              _handleGoogleButtonClick();
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                  child: Text('متابعة التسجيل',
                      style:
                          TextStyle(fontFamily: 'cairo', color: Colors.white))),
            ),
          ),
        ])
        /*Stack(
          children: [
            AnimatedPositioned(
                top: height * .15,
                right: _isAnimate ? width * .25 : width * .5,
                width: width * .5,
                duration: Duration(seconds: 1),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  height: height * .3,
                )),
            Positioned(
                bottom: height * .15,
                left: width * .05,
                width: width * .9,
                height: height * .05,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 219, 255, 178),
                        shape: StadiumBorder(),
                        elevation: 1),
                    onPressed: () {
                      _handleGoogleButtonClick();
                    },
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: height * .03,
                    ),
                    label: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * .05,
                            fontFamily: 'MyArabicFont',
                          ),
                          children: [
                            TextSpan(text: 'سجل دخول باستخدام '),
                            TextSpan(
                                text: 'جوجل',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'MyArabicFont',
                                    fontSize: width * .05)),
                          ]),
                    )))
          ],
        )*/
        ,
      ),
    );
  }
}
