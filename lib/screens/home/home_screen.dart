// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:omar_mostafa/helpers/log_out.dart';
// import 'package:omar_mostafa/models/my_user.dart';
// import 'package:omar_mostafa/screens/home_side_menu.dart';
// import 'package:omar_mostafa/widgets/section.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<MyUser> list = [];
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width,
//         height = MediaQuery.of(context).size.height;
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ));
//     return Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage('assets/images/background.PNG'))),
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color(0xff39A552),
//             shape: RoundedRectangleBorder(
//                 borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(35))),
//             title: Text(
//               'أ. عُمَرْ مُصْطَفَى',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'MyArabicFont',
//               ),
//             ),
//             centerTitle: true,
//           ),
//           drawer: Drawer(
//             child: HomeSideMenu(),
//           ),
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: EdgeInsets.all(width * .05),
//             child: GridView.builder(
//               physics: BouncingScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 22),
//               itemBuilder: (_, index) {
//                 return InkWell(
//                     onTap: () {
//                       /*onCategoryClickCallBack(categories[index]);
//                   title = categories[index].title;*/
//                     },
//                     child: sections[index]);
//               },
//               itemCount: sections.length,
//             ),
//           ),
//           floatingActionButton: Padding(
//             padding: EdgeInsets.only(bottom: 10),
//             child: FloatingActionButton(
//               onPressed: () {
//                 logOut(context);
//               },
//               child: Icon(Icons.logout),
//             ),
//           ),
//         ));
//   }
//
//   List<Section> sections = [
//     Section(Color(0xffc91c22), 'assets/images/teacher.png', 'مواعيد دروس', 1),
//     Section(Color(0xff003E90), 'assets/images/exam.png', 'مواعيد امتحانات', 2),
//     Section(Color(0xffED1E79), 'assets/images/booking.png', 'حجز', 3),
//     Section(
//         Color(0xffCF7E48), 'assets/images/telephone.png', 'معلومات تواصل', 4),
//     Section(
//         Color(0xff4882cf), 'assets/images/strategy.png', 'الخطة التعليمية', 5),
//     Section(Color(0xfff2d352), 'assets/images/schedule.png', 'جدول الحصص', 6),
//     Section(Colors.greenAccent, 'assets/images/complaint.png', 'تقديم شكوى', 7),
//     Section(Colors.purple, 'assets/images/growth.png', 'تقرير شهري', 8),
//     Section(Colors.lightBlueAccent, 'assets/images/feedback.png', 'تعليق', 9),
//     Section(Colors.deepOrange, 'assets/images/post.png', 'تنويهات أ. عمر', 10),
//   ];
// }

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/screens/home/dates_tab.dart';
import 'package:omar_mostafa/screens/home/main_tab/main_tab.dart';
import 'package:omar_mostafa/screens/home/profile_tab.dart';
import 'package:omar_mostafa/screens/home/strategy_tab.dart';

class HomeScreen extends StatefulWidget {
  static int selectedIndex = 3;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    ProfileTab(),
    StrategyTab(),
    DatesTab(),
    MainTab(),
  ];

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
        body: tabs[HomeScreen.selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: HomeScreen.selectedIndex,
          onItemSelected: (index) =>
              setState(() => HomeScreen.selectedIndex = index),
          items: [
            BottomNavyBarItem(
                icon: Icon(CupertinoIcons.person),
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
                icon: ImageIcon(AssetImage('assets/images/dates.png')),
                title: Text(
                  'المواعيد',
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
      ),
    );
  }
}
