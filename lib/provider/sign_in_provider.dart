import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/helpers/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final twitterLogin = TwitterLogin(
      apiKey: Config.apikey_twitter,
      apiSecretKey: Config.secretkey_twitter,
      redirectURI: "socialauth://");

  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;
  bool _hasError = false;

  bool get hasError => _hasError;
  String? _errorCode;

  String? get errorCode => _errorCode;
  String? _provider;

  String? get provider => _provider;
  String? _uid;

  String? get uid => _uid;
  String? _email;

  String? get email => _email;
  String? _imageUrl;

  String? get imageUrl => _imageUrl;
  String? _name;

  String? get name => _name;

  bool? _is_student;
  bool? get isStudent => _is_student;

  SignInProvider() {
    checkSignInUser();
  }

  Future checkSignInUser() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        final User userDetails =
            (await firebaseAuth.signInWithCredential(credential)).user!;
        _name = userDetails.displayName;
        _email = userDetails.email;
        _imageUrl = userDetails.photoURL;
        _provider = "GOOGLE";
        _uid = userDetails.uid;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode = "لديك حساب بالفعل";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "حدث خطأ ما!";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result.accessToken!.token}'));
    final profile = jsonDecode(graphResponse.body);
    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await firebaseAuth.signInWithCredential(credential);
        _name = profile['name'];
        _email = profile['email'];
        _imageUrl = profile['picture']['data']['url'];
        _uid = APIs.user.uid;
        _hasError = false;
        _provider = "FACEBOOK";
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode = "لديك حساب بالفعل";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "حدث خطأ ما!";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future signInWithTwitter() async {
    final authResult = await twitterLogin.loginV2();
    if (authResult.status == TwitterLoginStatus.loggedIn) {
      try {
        final credential = TwitterAuthProvider.credential(
            accessToken: authResult.authToken!,
            secret: authResult.authTokenSecret!);
        await firebaseAuth.signInWithCredential(credential);
        final userDetails = authResult.user;
        _name = userDetails?.name;
        _email = firebaseAuth.currentUser!.email;
        _imageUrl = userDetails?.thumbnailImage;
        _uid = APIs.user.uid;
        _provider = "TWITTER";
        _hasError = false;
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credential":
            _errorCode = "لديك حساب بالفعل";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "حدث خطأ ما!";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.toString();
            _hasError = true;
            notifyListeners();
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  Future getUserDataFromFirestore(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _uid = snapshot['id'];
      _name = snapshot['name'];
      _email = snapshot['email'];
      _imageUrl = snapshot['image'];
      _is_student = snapshot['is_student'];
      SherdHelper.saveData(key: "name", value: _name);
      SherdHelper.saveData(key: "id", value: _uid);
    });
  }

  Future saveDataToFireStore(bool is_student) async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "id": _uid,
      "image": _imageUrl,
      "is_student": is_student,
    });
    SherdHelper.saveData(key: "id", value: _uid);
    notifyListeners();
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString('name', _name ?? '');
    await s.setString('email', _email ?? '');
    await s.setString('uid', _uid ?? '');
    await s.setString('image_url', _imageUrl ?? '');
    await s.setBool('is_student', _is_student ?? true);
    notifyListeners();
  }

  Future getDataFromSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _name = s.getString('name');
    _email = s.getString('email');
    _imageUrl = s.getString('image_url');
    _uid = s.getString('uid');
    _is_student = s.getBool('is_student');
    notifyListeners();
  }

  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (snap.exists) {
      log('EXISTING USER');
      return true;
    } else {
      log('NEW USER');
      return false;
    }
  }

  Future userSignOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    _isSignedIn = false;
    notifyListeners();
    clearStorageData();
  }

  Future clearStorageData() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }

  void phoneNumberUser(User user, email, name, bool isStudent) {
    _name = name;
    _email = email;
    _imageUrl = "null";
    _uid = APIs.user.uid;
    _is_student = isStudent;
    _provider = "PHONE";
    notifyListeners();
  }
}

class SherdHelper {
  static SharedPreferences? sP;
  static init() async {
    sP = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await sP!.setString(key, value);
    if (value is int) return await sP!.setInt(key, value);
    if (value is bool) return await sP!.setBool(key, value);
    return await sP!.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sP?.get(key);
  }

  static Future<bool> deletData({required String key}) async {
    return await sP!.remove(key);
  }
}
