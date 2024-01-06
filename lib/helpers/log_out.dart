import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/provider/sign_in_provider.dart';
import 'package:omar_mostafa/screens/welcome/welcome_screen_i.dart';
import 'package:provider/provider.dart';

void logOut(BuildContext context) {
  final sp = context.read<SignInProvider>();
  showMessage(context, 'هل تريد تسجيل الخروج؟', posAction: () async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const WelcomeScreenI()));
    sp.userSignOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const WelcomeScreenI()));
  }, posActionName: 'نعم', negAction: () {}, negActionName: 'لا');
}