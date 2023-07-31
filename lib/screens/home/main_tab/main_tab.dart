import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/lessons.dart';
import 'package:omar_mostafa/models/post.dart';
import 'package:omar_mostafa/screens/home/main_tab/latest_changes.dart';
import 'package:omar_mostafa/widgets/lesson_widget.dart';
import 'package:omar_mostafa/widgets/post_widget.dart';

class MainTab extends StatefulWidget {
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
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
      padding: EdgeInsets.symmetric(horizontal: width * .05),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: height * .065,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(width * .039),
                  decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.circular(width * .05)),
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: width * .065,
                  ),
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'مرحبا ${name}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                    Text(
                      omar
                          ? 'تحكم في كل شيء يخص تطبيقك'
                          : '🤝🏻 !لنبدأ رحلة التعلم',
                      style: TextStyle(fontFamily: 'Cairo'),
                    )
                  ],
                ),
                SizedBox(
                  width: width * .05,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(height * .015),
                  child: CachedNetworkImage(
                    width: height * .055,
                    height: height * .055,
                    imageUrl: image ?? '',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person_alt)),
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Image.asset(
                  'assets/images/offer.png',
                  height: height * .3,
                ),
                Positioned(
                    top: height * .081,
                    right: width * .07,
                    child: omar
                        ? Text(
                            'تحكم في العروض',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'أفضل عرض لك',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: width * .5,
                          child: Text(
                            'عرض خاص على الدورات الجديدة بنصف الثمن',
                            style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.white,
                                fontSize: width * .03),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .07, vertical: height * .01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * .09),
                          ),
                          child: Text(
                            'عرض',
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                        )
                      ],
                    ))
              ],
            ),
            Row(
              children: [
                Text(
                  'عرض الكل',
                  style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                ),
                Expanded(child: Container()),
                Text(
                  'الدروس',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: width * .05),
                )
              ],
            ),
            LessonWidget(
                Lesson(number: 'الدرس الأول', name: 'الفيزياء الكهربية')),
            LessonWidget(
                Lesson(number: 'الدرس الثاني', name: 'الفيزياء الحديثة')),
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LatestChanges())),
                  child: Text(
                    'عرض الكل',
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  'أحدث التغيرات',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: width * .05),
                )
              ],
            ),
            Container(
              height: height * .3,
              child: StreamBuilder<QuerySnapshot<Post>>(
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
                              child: Text('لا يوجد تغيرات'),
                            )
                          : PostWidget(data[index]);
                    },
                    itemCount: data!.length,
                  );
                },
                // future: MyDataBase.getAllMissingPersons(),
                stream: APIs.getFirstTwoPosts(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}