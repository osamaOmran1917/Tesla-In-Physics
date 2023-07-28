import 'package:omar_mostafa/apis/apis.dart';
import 'package:omar_mostafa/models/my_user.dart';

class SharedData {
  static MyUser? user;
}

bool omar = APIs.user.uid == '6kfQ8I3Q2ATNqFia04aQnELDX123';