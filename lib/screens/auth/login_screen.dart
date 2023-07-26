import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/screens/home_screen.dart';
import 'package:omar_mostafa/screens/welcome_screen_i.dart';

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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => WelcomeScreenI()));
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
      Dialogs.showSnackbar(context, 'حدث خطأ ما. تأكد من اتصالك بالإنترنت!');
      return null;
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
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background.PNG'))),
      child: Scaffold(
        appBar: AppBar(
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
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
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
        ),
      ),
    );
  }
}
