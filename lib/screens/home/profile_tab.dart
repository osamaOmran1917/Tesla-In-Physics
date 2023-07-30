import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String name = '';
  String image = '';

  @override
  void initState() {
    super.initState();
    _getFieldValue();
  }

  Future<void> _getFieldValue() async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(APIs.user.uid)
        .get();
    var data = documentSnapshot.data();
    setState(() {
      name = data!['name'];
      image = data['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
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
                  children: [Text(name ?? '')],
                )
              ]))
        ],
      ),
    );
  }
}
