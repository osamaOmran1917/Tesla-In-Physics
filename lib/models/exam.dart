class Exam {
  Exam({
    required this.date,
  });

  late final String date;

  Exam.fromJson(Map<String, dynamic> json) {
    date = json['date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    return data;
  }
}
