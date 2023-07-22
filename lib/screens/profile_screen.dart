import 'package:flutter/material.dart';
import 'package:omar_mostafa/models/my_user.dart';

class ProfileScreen extends StatefulWidget {
  final MyUser user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
