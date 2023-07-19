import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omar_mostafa/screens/widgets/section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.PNG'))),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff39A552),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(35))),
            title: Text(
              'أ. عُمَرْ مُصْطَفَى',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'MyArabicFont',
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.all(width * .05),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 22),
              itemBuilder: (_, index) {
                return InkWell(
                    onTap: () {
                      /*onCategoryClickCallBack(categories[index]);
                  title = categories[index].title;*/
                    },
                    child: sections[index]);
              },
              itemCount: sections.length,
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
              },
              child: Icon(Icons.logout),
            ),
          ),
        ));
  }

  List<Section> sections = [
    Section(Color(0xffc91c22), 'assets/images/teacher.png', 'مواعيد دروس', 1),
    Section(Color(0xff003E90), 'assets/images/exam.png', 'مواعيد امتحانات', 2),
    Section(Color(0xffED1E79), 'assets/images/booking.png', 'حجز', 3),
    Section(
        Color(0xffCF7E48), 'assets/images/telephone.png', 'معلومات تواصل', 4)
  ];
}
