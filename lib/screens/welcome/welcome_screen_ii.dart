import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/screens/auth/login_screen.dart';

class WelcomeScreenII extends StatefulWidget {
  @override
  State<WelcomeScreenII> createState() => _WelcomeScreenIIState();
}

class _WelcomeScreenIIState extends State<WelcomeScreenII> {

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
      ),
    );
  }
}