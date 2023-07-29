import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/my_user.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  static MyUser? user;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    setUser();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .07),
      child: Column(
        children: [
          SizedBox(height: height * .119, width: double.infinity),
          Row(children: [
            Text(
              'الملف الشخصي',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: width * .05),
            ),
          ]),
          SizedBox(height: height * .05),
          Container(
              padding: EdgeInsets.all(width * .023),
              height: height * .083,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * .059),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: lightGreen.withOpacity(0.17),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(children: [
                Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: Colors.grey,
                ),
                Expanded(child: Container()),
                Column(
                  children: [Text(user?.name ?? '')],
                )
              ]))
        ],
      ),
    );
  }

  Future<void> setUser() async {
    user = await APIs.getFutureOfUserById(APIs.user.uid);
  }
}
