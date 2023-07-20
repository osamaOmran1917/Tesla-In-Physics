import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool studentChecked = false;
  bool parentChecked = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: height * .05,
          ),
          Text(
            'مستخدم الحساب طالب أم ولي أمر؟',
            style: TextStyle(fontFamily: 'MyArabicFont', fontSize: width * .05),
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
                  });
                },
                shape: CircleBorder(),
                activeColor: Color(0xff39A552),
              ),
              Text(
                'ولي أمر',
                style: TextStyle(
                    fontFamily: 'MyArabicFont', fontSize: width * .05),
              )
            ],
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
                if (studentChecked)
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                else {
                  APIs.setAsParent(APIs.user.uid);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
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
    );
  }
}
