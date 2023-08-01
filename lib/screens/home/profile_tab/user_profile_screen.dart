import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';

class UsereProfileScreen extends StatefulWidget {
  @override
  State<UsereProfileScreen> createState() => _UsereProfileScreenState();
}

class _UsereProfileScreenState extends State<UsereProfileScreen> {
  String name = '';
  String image = '';
  String email = '';

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
      email = data['email'];
    });
  }

  int? level;

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
              image: AssetImage('assets/images/designed_background.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .061),
          child: Column(
            children: [
              SizedBox(
                height: height * .067,
                width: double.infinity,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(width * .039),
                      decoration: BoxDecoration(
                          color: lightGreen,
                          borderRadius: BorderRadius.circular(width * .05)),
                      child: Icon(
                        Icons.keyboard_arrow_left_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'تعديل البيانات',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        fontSize: width * .05),
                  ),
                ],
              ),
              SizedBox(
                height: height * .05,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(height * .1),
                child: CachedNetworkImage(
                  width: height * .15,
                  height: height * .15,
                  imageUrl: image,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => CircleAvatar(
                    child: Icon(CupertinoIcons.person_alt),
                  ),
                ),
              ),
              Text(
                email,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: width * .041,
                    fontWeight: FontWeight.bold),
              ),
              Visibility(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'المرحلة الدراسية',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .013,
              ),
              Visibility(
                child: Container(
                  height: height * .07,
                  width: width * .85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * .039),
                    boxShadow: [
                      BoxShadow(
                        color: lightGreen.withOpacity(0.17),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 1) {
                          setState(() {
                            level = 1;
                          });
                        } else if (value == 2) {
                          setState(() {
                            level = 2;
                          });
                        } else {
                          setState(() {
                            level = 3;
                          });
                        }
                      },
                      icon: Row(
                        children: [
                          ImageIcon(AssetImage('assets/images/down.png')),
                          Expanded(child: Container()),
                          Text(
                            level == null
                                ? 'اختر مرحلة دراسية'
                                : level.toString(),
                            style: TextStyle(
                                fontFamily: 'Cairo', color: Colors.grey),
                          )
                        ],
                      ),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('1'),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text('2'),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text('3'),
                              value: 3,
                            ),
                          ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
