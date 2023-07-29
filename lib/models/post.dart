class Post {
  static const String collectionName = 'posts';
  String? id;
  String? title;
  String? details;
  String? date_time;

  Post({this.id, this.title, this.details, this.date_time});

  Post.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            details: data['details'],
            date_time: data['date_time']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'date_time': date_time
    };
  }
}
