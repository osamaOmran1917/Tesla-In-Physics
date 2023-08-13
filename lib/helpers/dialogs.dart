import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';

class Dialogs {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontFamily: 'cairo', color: Colors.black),
        textAlign: TextAlign.center,
      ),
      backgroundColor: omarYellow,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(child: CircularProgressIndicator()));
  }
}

void showLoading(BuildContext context, String loadingMessage,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 12,
              ),
              Text(
                loadingMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        );
      },
      barrierDismissible: isCancelable);
}

void showMessage(BuildContext context, String message,
    {String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
    bool isCancelable = true}) {
  List<Widget> actions = [];
  if (posActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) posAction();
        },
        child: Text(posActionName)));
  }

  if (negActionName != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (negAction != null) negAction();
        },
        child: Text(negActionName)));
  }

  showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
            content: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            actions: actions);
      },
      barrierDismissible: isCancelable);
}