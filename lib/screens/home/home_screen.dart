import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/date_utils.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/strategy_post.dart';
import 'package:omar_mostafa/provider/sign_in_provider.dart';
import 'package:omar_mostafa/screens/home/attendance_tab/attendance_tab.dart';
import 'package:omar_mostafa/screens/home/main_tab/main_tab.dart';
import 'package:omar_mostafa/screens/home/profile_tab/profile_tab.dart';
import 'package:omar_mostafa/screens/home/strategy_tab.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static int selectedIndex = 3;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    ProfileTab(),
    StrategyTab(),
    AttendanceTab(),
    MainTab(),
  ];

  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  int? level;

  Future getData() async {
    final sp = context.watch<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    APIs.getFirebaseMessagingToken();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final sp = context.read<SignInProvider>();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/designed_background.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: tabs[HomeScreen.selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: HomeScreen.selectedIndex,
          onItemSelected: (index) =>
              setState(() => HomeScreen.selectedIndex = index),
          items: [
            BottomNavyBarItem(
                icon: ImageIcon(AssetImage('assets/images/Profile.png')),
                title: Text(
                  'البروفايل',
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
                activeColor: lightGreen,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: ImageIcon(AssetImage('assets/images/Document.png')),
                title: Text(
                  'الخطة التعليمية',
                  style:
                      TextStyle(fontFamily: 'Cairo', fontSize: width * .0281),
                ),
                activeColor: lightGreen,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: ImageIcon(AssetImage('assets/images/attendance.png')),
                title: Text(
                  'الحضور',
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
                activeColor: lightGreen,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: ImageIcon(AssetImage('assets/images/Home.png')),
                title: Text(
                  'الرئيسية',
                  style: TextStyle(fontFamily: 'Cairo'),
                ),
                activeColor: lightGreen,
                textAlign: TextAlign.center,
                inactiveColor: Colors.grey),
          ],
        ),
        floatingActionButton: (HomeScreen.selectedIndex == 1 && omar)
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.all(width * .05),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * .05,
                              ),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(
                                  labelText: 'العنوان',
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * .05),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .05,
                              ),
                              TextField(
                                controller: detailsController,
                                decoration: InputDecoration(
                                  labelText: 'التفاصيل',
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * .05),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .05,
                              ),
                              Container(
                                height: height * .07,
                                width: width * .85,
                                decoration: BoxDecoration(
                                  border: Border.all(width: width * .001),
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(width * .043),
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
                                        ImageIcon(AssetImage(
                                            'assets/images/down.png')),
                                        Expanded(child: Container()),
                                        Text(
                                          level == null
                                              ? 'اختر مرحلة دراسية'
                                              : level.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    shape: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                              Expanded(child: Container()),
                              ElevatedButton(
                                  onPressed: () {
                                    StrategyPost strategyPost =
                                        new StrategyPost(
                                            title:
                                                titleController.text.toString(),
                                            details: detailsController.text
                                                .toString(),
                                            level: level,
                                            date_time:
                                                dateOnly(DateTime.now()));
                                    APIs.addStrategyPost(strategyPost);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'نشر',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: width * .05),
                                  ))
                            ],
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(width * .1),
                              topLeft: Radius.circular(width * .1))));
                },
                backgroundColor: lightGreen,
                child: Icon(CupertinoIcons.add),
              )
            : null,
      ),
    );
  }
}