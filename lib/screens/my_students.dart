import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/models/my_user.dart';
import 'package:omar_mostafa/widgets/user_card.dart';

class MyStudents extends StatefulWidget {
  const MyStudents({Key? key}) : super(key: key);

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {
  List<MyUser> list = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder(
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list = data?.map((e) => MyUser.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) {
                return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(top: height * .01),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return UserCard(user: list[index]);
                    });
              } else {
                return Center(
                    child: Text(
                  'لا يوجد طلبة',
                  style: TextStyle(fontFamily: 'MyArabicFont', fontSize: 20),
                ));
              }
          }
        },
      ),
    );
  }
}