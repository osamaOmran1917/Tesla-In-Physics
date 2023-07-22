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
    required this.phone_I,
    required this.phone_II,
    required this.is_student,
    required this.lessons_num,
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
  late final String phone_I;
  late final String phone_II;
  late final bool is_student;
  late final int lessons_num;

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
    phone_I = json['phone_I'] ?? '';
    phone_II = json['phone_II'] ?? '';
    is_student = json['is_student'] ?? '';
    lessons_num = json['lessons_num'] ?? '';
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
    data['phone_I'] = phone_I;
    data['phone_II'] = phone_II;
    data['is_student'] = is_student;
    data['lessons_num'] = lessons_num;
    return data;
  }
}
