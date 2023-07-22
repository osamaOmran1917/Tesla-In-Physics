import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/screens/my_students.dart';

class HomeSideMenu extends StatelessWidget {
  const HomeSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            icon: Icon(CupertinoIcons.group_solid),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => MyStudents())),
          ),
        ],
      ),
    );
  }
}
