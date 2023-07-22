import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/screens/my_students.dart';

class HomeSideMenu extends StatelessWidget {
  // final MyUser user;
  const HomeSideMenu({Key? key /*, required this.user*/
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          if (omar)
            IconButton(
              icon: Icon(
                CupertinoIcons.group_solid,
                color: Color(0xff39A552),
              ),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyStudents())),
            ),
          if (omar)
            TextButton(
              child: Text('التلاميذ',
                  style: TextStyle(
                      fontFamily: 'MyArabicFont',
                      fontSize: width * .09,
                      color: Color(0xff39A552))),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyStudents()));
              },
            ),
          if (!omar) Text(':رمز حسابك هو'),
          if (!omar) Text(APIs.user.uid),
          if (!omar)
            ElevatedButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: APIs.user.uid));
                },
                child: Text('نسخ الرمز'))
        ],
      ),
    );
  }
}
