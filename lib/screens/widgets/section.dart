import 'package:flutter/cupertino.dart';

class Section extends StatelessWidget {
  Color color;
  Widget icon;
  String lable;
  int index;

  Section(this.color, this.icon, this.lable, this.index);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
              topRight: index % 4 != 3
                  ? Radius.circular(width * .075)
                  : Radius.circular(0),
              topLeft: index % 4 != 0
                  ? Radius.circular(width * .075)
                  : Radius.circular(0),
              bottomRight: index % 4 != 1
                  ? Radius.circular(width * .075)
                  : Radius.circular(0),
              bottomLeft: index % 4 != 2
                  ? Radius.circular(width * .075)
                  : Radius.circular(0))),
      child: Column(
        children: [
          icon,
          Text(
            lable,
            style: TextStyle(
              fontFamily: 'MyArabicFont',
            ),
          )
        ],
      ),
    );
  }
}
