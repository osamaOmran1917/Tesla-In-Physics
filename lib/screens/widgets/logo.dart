import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Container(
      width: width * .7,
      height: width * .5,
      child: Stack(
        children: [
          Positioned(
              child: Text(
            'TE',
            style: TextStyle(
                color: Color(0xff39A552),
                fontFamily: 'Austere',
                fontSize: width * .15),
          )),
          Positioned(
              right: width * .23,
              child: Icon(
                Icons.electric_bolt,
                color: Color(0xFFF6C515),
                size: width * .3,
              )),
          Positioned(
              right: width * .017,
              child: Text(
                'LA',
                style: TextStyle(
                    color: Color(0xff39A552),
                    fontFamily: 'Austere',
                    fontSize: width * .15),
              )),
          Positioned(
              top: height * .09,
              right: width * .41,
              child: Text(
                'in',
                style: TextStyle(color: Color(0xff39A552)),
              )),
          Positioned(
              top: height * .09,
              right: width * .21,
              child: Text(
                'physics',
                style: TextStyle(color: Color(0xff39A552)),
              ))
        ],
      ),
    );
  }
}
