import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/screens/welcome/welcome_screen_ii.dart';

class WelcomeScreenI extends StatefulWidget {
  @override
  State<WelcomeScreenI> createState() => _WelcomeScreenIState();
}

class _WelcomeScreenIState extends State<WelcomeScreenI> {

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
              image: AssetImage('assets/images/wallpaper_i.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => WelcomeScreenII())),
          child: Image.asset('assets/images/half_floating.png'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }
}