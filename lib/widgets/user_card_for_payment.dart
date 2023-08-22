import 'package:flutter/material.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/models/my_user.dart';

class UserCardForPayment extends StatefulWidget {
  MyUser user;
  late Color color;

  UserCardForPayment(this.user);

  @override
  State<UserCardForPayment> createState() => _UserCardForPaymentState();
}

class _UserCardForPaymentState extends State<UserCardForPayment> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    late var paid;
    paid = widget.user.paid;
    widget.color = paid == true ? lightGreen : Colors.white;
    return Visibility(
      visible: widget.user.id != '6kfQ8I3Q2ATNqFia04aQnELDX123',
      child: GestureDetector(
        onTap: () {
          if (paid == true) {
            setState(() {
              paid = false;
              APIs.updatePayment(widget.user.id, false);
            });
          } else {
            setState(() {
              paid = true;
              APIs.updatePayment(widget.user.id, true);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: height * .021),
          padding: EdgeInsets.all(width * .05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * .05),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: lightGreen.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * .055,
                height: width * .055,
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.circular(width),
                    border:
                        Border.all(color: Colors.grey, width: width * .003)),
              ),
              Text(
                widget.user.name,
                style: TextStyle(
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: width * .039),
              )
            ],
          ),
        ),
      ),
    );
  }
}
