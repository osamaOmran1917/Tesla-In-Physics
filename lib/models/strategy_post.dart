class StrategyPost {
  static const String collectionName = 'strategy_posts';
  String? id;
  String? title;
  String? details;
  int? level;
  DateTime? date_time;

  StrategyPost({this.id, this.title, this.details, this.date_time, this.level});

  StrategyPost.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            details: data['details'],
            level: data['level'],
            date_time: DateTime.fromMillisecondsSinceEpoch(data['date_time']));

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'level': level,
      'date_time': date_time?.millisecondsSinceEpoch
    };
  }
}
