import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/log_out.dart';
import 'package:omar_mostafa/helpers/shared_data.dart';

class MainTab extends StatelessWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .05),
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
                children: [Text('مرحبا ${SharedData.user?.name ?? ''}')],
              ),
              InkWell(
                  onTap: () => logOut(context),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(height * .015),
                    child: CachedNetworkImage(
                      width: height * .055,
                      height: height * .055,
                      imageUrl: SharedData.user?.image ?? '',
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person_alt)),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
