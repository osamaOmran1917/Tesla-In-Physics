import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .07),
      child: Column(
        children: [
          SizedBox(
            height: height * .119,
          ),
          Text(
            'الملف الشخصي',
            style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: width * .05),
          )
        ],
      ),
    );
  }
}

class ProfielCards extends StatelessWidget {
  const ProfielCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Card(
      color: Colors.white,
      elevation: .5,
      margin: EdgeInsets.symmetric(horizontal: width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        /*leading: ClipRRect(
          borderRadius: BorderRadius.circular(height * .3),
          child: CachedNetworkImage(
            width: height * .055,
            height: height * .055,
            imageUrl: widget.user.image,
            errorWidget: (context, url, error) =>
                CircleAvatar(child: Icon(CupertinoIcons.person_alt)),
          ),
        ),*/
        /* title: Text(widget.user.name),
        subtitle: Text(widget.user.about),*/
        trailing: Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              color: Colors.redAccent.shade400,
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
