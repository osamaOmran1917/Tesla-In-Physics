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
  int? jan_1;
  int? jan_2;
  int? jan_3;
  int? jan_4;
  int? jan_5;
  int? jan_6;
  int? jan_7;
  int? jan_8;
  int? jan_9;
  int? jan_10;
  int? jan_11;
  int? jan_12;

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
    return data;
  }
}