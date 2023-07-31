import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';
import 'package:omar_mostafa/models/post.dart';
import 'package:omar_mostafa/widgets/post_widget.dart';

class LatestChanges extends StatelessWidget {
  var titleController = TextEditingController();
  var detailsController = TextEditingController();
  var dateController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * .067,
              ),
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
              Text(
                'أحدث التغيرات',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: width * .05),
              ),
              Expanded(
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
                    var data =
                    snapshot.data?.docs.map((e) => e.data()).toList();
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (buildContext, index) {
                        return data.isEmpty
                            ? Center(
                          child: Text('لا يوجد تغييرات'),
                        )
                            : InkWell(
                            onTap: () {}, child: PostWidget(data[index]));
                      },
                      itemCount: data!.length,
                    );
                  },
                  // future: MyDataBase.getAllMissingPersons(),
                  stream: APIs.ListenForPostsRealTimeUpdates(),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: omar
            ? FloatingActionButton(
          backgroundColor: lightGreen,
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
                              TextField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  labelText: 'يمكنك إضافة موعد',
                                  labelStyle: TextStyle(fontFamily: 'Cairo'),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * .05),
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              ElevatedButton(
                                  onPressed: () {
                                    Post post = new Post(
                                        title: titleController.text.toString(),
                                        details:
                                            detailsController.text.toString(),
                                        textDate:
                                            dateController.text.toString());
                                    APIs.addPost(post);
                                    Navigator.pop(context);
                                    print(dateController.text.toString());
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
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        )
            : null,
      ),
    );
  }
}
