import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/screens/auth/login_screen.dart';

void logOut(BuildContext context) {
  showMessage(context, 'هل تريد تسجيل الخروج؟', posAction: () async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }, posActionName: 'نعم', negAction: () {}, negActionName: 'لا');
}
