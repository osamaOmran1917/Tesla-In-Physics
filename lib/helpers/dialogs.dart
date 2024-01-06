import 'package:flutter/material.dart';
import 'package:omar_mostafa/helpers/colors.dart';

class Dialogs {
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontFamily: 'cairo', color: Colors.black),
        textAlign: TextAlign.center,
      ),
      backgroundColor: omarYellow,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Center(
                child: CircularProgressIndicator(
              color: lightGreen,
            )));
  }
}

void showLoading(BuildContext context, String loadingMessage,
    {bool isCancelable = true}) {
  showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircularProgressIndicator(color: lightGreen),
              Text(
                loadingMessage,
                style: const TextStyle(fontFamily: 'cairo'),
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