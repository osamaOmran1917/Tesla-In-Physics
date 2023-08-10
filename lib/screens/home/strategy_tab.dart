import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/strategy_post.dart';
import 'package:omar_mostafa/widgets/strategy_post_widget.dart';

class StrategyTab extends StatefulWidget {
  @override
  State<StrategyTab> createState() => _StrategyTabState();
}

class _StrategyTabState extends State<StrategyTab> {
  int userLevel = 0;

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
    if (data!['is_student'] == true)
      setState(() {
        userLevel = data['level'];
      });
    else {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(data['student_id'])
          .get();
      var newData = documentSnapshot.data();
      setState(() {
        userLevel = newData!['level'];
      });
    }
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
              'الخطة التعليمية',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  fontSize: width * .05),
            ),
          ]),
          SizedBox(
            height: height * .03,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<StrategyPost>>(
              builder: (buildContext, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('خطأ في تحميل البيانات حاول لاحقا'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: lightGreen),
                  );
                }
                var data = snapshot.data?.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (buildContext, index) {
                    return data.isEmpty
                        ? Center(
                            child: Text('لا يوجد خطط حتى الآن'),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: StrategyPostWidget(data[index]));
                  },
                  itemCount: data!.length,
                );
              },
              stream: omar
                  ? APIs.ListenForStrategyPostsRealTimeUpdates()
                  : APIs.ListenForLevelStrategyPostsRealTimeUpdates(userLevel),
            ),
          ),
        ],
      ),
    );
  }
}
