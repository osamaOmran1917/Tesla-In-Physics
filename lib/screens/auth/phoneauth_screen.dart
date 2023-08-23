import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omar_mostafa/helpers/colors.dart';
import 'package:omar_mostafa/helpers/dialogs.dart';
import 'package:omar_mostafa/provider/internet_provider.dart';
import 'package:omar_mostafa/provider/sign_in_provider.dart';
import 'package:omar_mostafa/screens/auth/complete_user_data.dart';
import 'package:omar_mostafa/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreen extends StatefulWidget {
  bool is_student;

  PhoneAuthScreen(this.is_student);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/designed_background.jpg'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * .065, vertical: height * .07),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset('assets/images/back.png')),
                      ],
                    ),
                    Text(
                      'أدخل رقم هاتفك',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'الهاتف',
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .013,
                    ),
                    Container(
                      height: height * .07,
                      width: width * .85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * .039),
                        boxShadow: [
                          BoxShadow(
                            color: lightGreen.withOpacity(0.17),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: TextStyle(fontFamily: 'cairo'),
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يجب ادخال رقم الهاتف';
                          }
                          return null;
                        },
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          hintText: '+201234567890',
                          hintStyle: TextStyle(
                              fontFamily: 'Cairo', color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: width * .03),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              lightGreen), // Set custom button color
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  width * .03), // Adjust the value as needed
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(Size(
                              width * .85,
                              height * .05)), // Set custom button size
                        ),
                        onPressed: () {
                          login(context, phoneController.text.trim());
                        },
                        child: Text(
                          'متابعة',
                          style: TextStyle(fontFamily: 'cairo'),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future login(BuildContext context, String mobile) async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();
    if (ip.hasInternet == false) {
      Dialogs.showSnackbar(context, 'تأكد من الاتصال بالانترنت');
    } else {
      if (formKey.currentState!.validate()) {
        FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: mobile,
            verificationCompleted: (AuthCredential credential) async {
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              Dialogs.showSnackbar(context, e.toString());
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('ادخل الرمز'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: otpCodeController,
                            decoration:
                                InputDecoration(prefixIcon: Icon(Icons.code)),
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                final code = otpCodeController.text.trim();
                                AuthCredential authCredential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: code);
                                User user = (await FirebaseAuth.instance
                                        .signInWithCredential(authCredential))
                                    .user!;
                                sp.phoneNumberUser(
                                    user, '', '', widget.is_student);
                                sp.checkUserExists().then((value) async {
                                  if (value == true) {
                                    await sp
                                        .getUserDataFromFirestore(sp.uid)
                                        .then((value) => sp
                                            .saveDataToSharedPreferences()
                                            .then((value) =>
                                                sp.setSignIn().then((value) {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              HomeScreen()));
                                                })));
                                  } else {
                                    sp
                                        .saveDataToFireStore(widget.is_student)
                                        .then(
                                          (value) => sp.setSignIn().then(
                                            (value) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CompleteUserData(
                                                              widget.is_student,
                                                              true)));
                                            },
                                          ),
                                        );
                                  }
                                });
                              },
                              child: Text('تأكيد'))
                        ],
                      ),
                    );
                  },
                  barrierDismissible: false);
            },
            codeAutoRetrievalTimeout: (String verification) {});
      }
    }
  }
}
