import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/screens/widgets/section.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.PNG'))),
        child: Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35))),
              title: Text(
                'أ. عُمَرْ مُصْطَفَى',
                textAlign: TextAlign.center,
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
            )));
  }

  List<Section> sections = [
    Section(Color(0xffc91c22), Icon(CupertinoIcons.doc), 'مواعيد دروس', 1),
    Section(Color(0xff003E90), Icon(CupertinoIcons.doc_checkmark),
        'مواعيد امتحانات', 2),
    Section(Color(0xffED1E79), Icon(CupertinoIcons.bookmark_fill), 'حجز', 3),
    Section(Color(0xffCF7E48), Icon(CupertinoIcons.info), 'معلومات تواصل', 4)
  ];
}
