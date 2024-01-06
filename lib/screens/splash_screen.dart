import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/screens/home/home_screen.dart';
import 'package:omar_mostafa/screens/welcome/welcome_screen_i.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));
      APIs.auth.currentUser == null
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const WelcomeScreenI()))
          : /*(name!.isEmpty || name == null)? Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CompleteUserData(isStudent, true))):*/ Navigator
              .pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
      decoration: const BoxDecoration(
          color: darkGreen,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/splash_wallpaper.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height * .855,
            ),
            Image.asset('assets/images/splash_cycle.png')
          ],
        ),
      ),
    );
  }
}
