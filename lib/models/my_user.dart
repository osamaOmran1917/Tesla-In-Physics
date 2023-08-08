class MyUser {
  MyUser({
    required this.image,
    required this.address,
    required this.name,
    required this.about,
    required this.createdAt,
    required this.lastActive,
    required this.id,
    required this.isOnline,
    required this.email,
    required this.pushToken,
    required this.phone,
    required this.is_student,
    required this.lessons_num,
    required this.student_id,
    required this.level,
    required this.male,
    required this.jan_1,
    required this.jan_2,
    required this.jan_3,
    required this.jan_4,
    required this.jan_5,
    required this.jan_6,
    required this.jan_7,
    required this.jan_8,
    required this.jan_9,
    required this.jan_10,
    required this.jan_11,
    required this.jan_12,
    required this.feb_1,
    required this.feb_2,
    required this.feb_3,
    required this.feb_4,
    required this.feb_5,
    required this.feb_6,
    required this.feb_7,
    required this.feb_8,
    required this.feb_9,
    required this.feb_10,
    required this.feb_11,
    required this.feb_12,
    required this.aug_1,
    required this.aug_2,
    required this.aug_3,
    required this.aug_4,
    required this.aug_5,
    required this.aug_6,
    required this.aug_7,
    required this.aug_8,
    required this.aug_9,
    required this.aug_10,
    required this.aug_11,
    required this.aug_12,
  });

  late final String image;
  late final String address;
  late final String name;
  late final String about;
  late final String createdAt;
  late final String lastActive;
  late final String id;
  late final bool isOnline;
  late final String email;
  late final String pushToken;
  late final String phone;
  late final bool is_student;
  late final int lessons_num;
  late final String student_id;
  late final int level;
  late final bool male;
  late final jan_1;
  late final jan_2;
  late final jan_3;
  late final jan_4;
  late final jan_5;
  late final jan_6;
  late final jan_7;
  late final jan_8;
  late final jan_9;
  late final jan_10;
  late final jan_11;
  late final jan_12;
  late final feb_1;
  late final feb_2;
  late final feb_3;
  late final feb_4;
  late final feb_5;
  late final feb_6;
  late final feb_7;
  late final feb_8;
  late final feb_9;
  late final feb_10;
  late final feb_11;
  late final feb_12;
  late final aug_1;
  late final aug_2;
  late final aug_3;
  late final aug_4;
  late final aug_5;
  late final aug_6;
  late final aug_7;
  late final aug_8;
  late final aug_9;
  late final aug_10;
  late final aug_11;
  late final aug_12;

  MyUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    address = json['address'] ?? '';
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    createdAt = json['created_at'] ?? '';
    lastActive = json['last_active'] ?? '';
    id = json['id'] ?? '';
    isOnline = json['is_online'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    phone = json['phone'] ?? '';
    is_student = json['is_student'] ?? '';
    lessons_num = json['lessons_num'] ?? '';
    student_id = json['student_id'] ?? '';
    level = json['level'] ?? '';
    male = json['male'] ?? '';
    jan_1 = json['jan_1'];
    jan_2 = json['jan_2'];
    jan_3 = json['jan_3'];
    jan_4 = json['jan_4'];
    jan_5 = json['jan_5'];
    jan_6 = json['jan_6'];
    jan_7 = json['jan_7'];
    jan_8 = json['jan_8'];
    jan_9 = json['jan_9'];
    jan_10 = json['jan_10'];
    jan_11 = json['jan_11'];
    jan_12 = json['jan_12'];
    feb_1 = json['feb_1'];
    feb_2 = json['feb_2'];
    feb_3 = json['feb_3'];
    feb_4 = json['feb_4'];
    feb_5 = json['feb_5'];
    feb_6 = json['feb_6'];
    feb_7 = json['feb_7'];
    feb_8 = json['feb_8'];
    feb_9 = json['feb_9'];
    feb_10 = json['feb_10'];
    feb_11 = json['feb_11'];
    feb_12 = json['feb_12'];
    aug_1 = json['aug_1'];
    aug_2 = json['aug_2'];
    aug_3 = json['aug_3'];
    aug_4 = json['aug_4'];
    aug_5 = json['aug_5'];
    aug_6 = json['aug_6'];
    aug_7 = json['aug_7'];
    aug_8 = json['aug_8'];
    aug_9 = json['aug_9'];
    aug_10 = json['aug_10'];
    aug_11 = json['aug_11'];
    aug_12 = json['aug_12'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['address'] = address;
    data['name'] = name;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['last_active'] = lastActive;
    data['id'] = id;
    data['is_online'] = isOnline;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['phone'] = phone;
    data['is_student'] = is_student;
    data['lessons_num'] = lessons_num;
    data['student_id'] = student_id;
    data['level'] = level;
    data['male'] = male;
    data['jan_1'] = jan_1;
    data['jan_2'] = jan_2;
    data['jan_3'] = jan_3;
    data['jan_4'] = jan_4;
    data['jan_5'] = jan_5;
    data['jan_6'] = jan_6;
    data['jan_7'] = jan_7;
    data['jan_8'] = jan_8;
    data['jan_9'] = jan_9;
    data['jan_10'] = jan_10;
    data['jan_11'] = jan_11;
    data['jan_12'] = jan_12;
    data['feb_1'] = feb_1;
    data['feb_2'] = feb_2;
    data['feb_3'] = feb_3;
    data['feb_4'] = feb_4;
    data['feb_5'] = feb_5;
    data['feb_6'] = feb_6;
    data['feb_7'] = feb_7;
    data['feb_8'] = feb_8;
    data['feb_9'] = feb_9;
    data['feb_10'] = feb_10;
    data['feb_11'] = feb_11;
    data['feb_12'] = feb_12;
    data['aug_1'] = aug_1;
    data['aug_2'] = aug_2;
    data['aug_3'] = aug_3;
    data['aug_4'] = aug_4;
    data['aug_5'] = aug_5;
    data['aug_6'] = aug_6;
    data['aug_7'] = aug_7;
    data['aug_8'] = aug_8;
    data['aug_9'] = aug_9;
    data['aug_10'] = aug_10;
    data['aug_11'] = aug_11;
    data['aug_12'] = aug_12;
    return data;
  }
}