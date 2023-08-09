import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/log_out.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/screens/home/profile_tab/exams/exams_screen.dart';
import 'package:omar_mostafa/screens/home/profile_tab/user_profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
            InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UsereProfileScreen())),
              child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          name ?? '',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                        Text('تعديل البيانات الشخصية',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.grey,
                                fontSize: width * .0265))
                      ],
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(height * .3),
                      child: CachedNetworkImage(
                        width: height * .055,
                        height: height * .055,
                        imageUrl: image,
                        errorWidget: (context, url, error) => CircleAvatar(
                            child: Icon(CupertinoIcons.person_alt)),
                      ),
                    )
                  ])),
            ),
            SizedBox(
              height: height * .03,
            ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        omar ? 'الاشتراكات' : 'اشترك',
                        style: TextStyle(
                            fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * .03,
                  ),
                  Container(
                    width: height * .055,
                    height: height * .055,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * .3),
                        color: lightGreen),
                    child: Image.asset(
                      'assets/images/Ticket.png',
                    ),
                  )
                ])),
            SizedBox(
              height: height * .03,
            ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'دعوة أصدقاء',
                        style: TextStyle(
                            fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width * .03,
                  ),
                  Container(
                    width: height * .055,
                    height: height * .055,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * .3),
                        color: lightGreen),
                    child: Icon(
                      CupertinoIcons.person_badge_plus,
                      color: Colors.white,
                    ),
                  )
                ])),
            SizedBox(
              height: height * .03,
            ),
            InkWell(
              onTap: () {
                _launchInBrowser(Uri.parse(
                    'whatsapp://send?phone=+201128122882&text=السلام عليكم، مستر عمر. لدي تعليق..'));
              },
              child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          omar ? 'التواصل' : 'تواصل معنا',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                      width: height * .055,
                      height: height * .055,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height * .3),
                          color: lightGreen),
                      child: Icon(
                        CupertinoIcons.checkmark_shield,
                        color: Colors.white,
                      ),
                    )
                  ])),
            ),
            SizedBox(
              height: height * .03,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ExamsScreen()));
              },
              child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الاختبارات',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                      width: height * .055,
                      height: height * .055,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height * .3),
                          color: lightGreen),
                      child: Image.asset(
                        'assets/images/exams.png',
                      ),
                    )
                  ])),
            ),
            SizedBox(
              height: height * .03,
            ),
            InkWell(
              onTap: () => logOut(context),
              child: Container(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'تسجيل خروج',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * .03,
                    ),
                    Container(
                      width: height * .055,
                      height: height * .055,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height * .3),
                          color: lightGreen),
                      child: Image.asset(
                        'assets/images/Logout.png',
                      ),
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
