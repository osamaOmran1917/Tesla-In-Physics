import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/widgets/cell.dart';

class DatesTab extends StatelessWidget {
  const DatesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(height: height * .119, width: double.infinity),
        Row(children: [
          SizedBox(
            width: width * .07,
          ),
          Text(
            'المواعيد',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: width * .05),
          ),
        ]),
        SizedBox(height: height * .05),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: [
              Column(
                children: [
                  Cell(
                    'شفوي',
                    lightGreen,
                    width * .141,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .141),
                ],
              ),
              Column(
                children: [
                  Cell(
                    'واجب حصة',
                    lightGreen,
                    width * .241,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .241),
                ],
              ),
              Column(
                children: [
                  Cell(
                    'حضور/التاريخ',
                    lightGreen,
                    width * .25,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('', Colors.white, width * .25),
                ],
              ),
              Column(
                children: [
                  Cell(
                    'المحاضرة',
                    lightGreen,
                    width * .19,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('الأولى', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('الثانية', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('الثالثة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('الرابعة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('الخامسة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('السادسة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('السابعة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('الثامنة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('التاسعة', Colors.white, width * .19),
                  SizedBox(
                    height: height * .02,
                  ),
                  Cell('العاشرة', Colors.white, width * .19),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
