import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
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
                child: Image.asset('images/icon.png')),
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
                      // _handleGoogleBtnClick();
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
