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
    return data;
  }
}
