import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF00797D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/splash_pic.jpg',
            width: width * .7,
          ),
          TypewriterAnimatedTextKit(
            text: ['أ. عُمَرْ مُصْطَفَى'],
            textStyle: TextStyle(
                fontFamily: 'MyArabicFont',
                fontSize: width * .099,
                color: Colors.white),
            speed: Duration(milliseconds: 150),
            totalRepeatCount: 1,
          ),
        ],
      ),
    );
  }
}
