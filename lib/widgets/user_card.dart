import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/models/my_user.dart';

class UserCard extends StatefulWidget {
  final MyUser user;

  const UserCard({super.key, required this.user});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Card(
      color: Color.fromARGB(255, 219, 255, 178),
      elevation: .5,
      margin: EdgeInsets.symmetric(horizontal: width * .04, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(height * .3),
          child: CachedNetworkImage(
            width: height * .055,
            height: height * .055,
            imageUrl: widget.user.image,
            errorWidget: (context, url, error) =>
                CircleAvatar(child: Icon(CupertinoIcons.person_alt)),
          ),
        ),
        title: Text(widget.user.name),
        subtitle: Text(widget.user.about),
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
