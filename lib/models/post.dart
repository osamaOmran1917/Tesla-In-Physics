class Post {
  static const String collectionName = 'posts';
  String? id;
  String? title;
  String? details;
  String? textDate;
  int? level;
  DateTime? date_time;

  Post(
      {this.id,
      this.title,
      this.details,
      this.date_time,
      this.textDate,
      this.level});

  Post.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            details: data['details'],
            textDate: data['textDate'],
            level: data['level'],
            date_time: DateTime.fromMillisecondsSinceEpoch(data['date_time']));

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'textDate': textDate,
      'level': level,
      'date_time': date_time?.millisecondsSinceEpoch
    };
  }
}
