class StrategyPost {
  static const String collectionName = 'strategy_posts';
  String? id;
  String? title;
  String? details;
  String? time;
  int? level;
  DateTime? date_time;

  StrategyPost(
      {this.id,
      this.title,
      this.details,
      this.date_time,
      this.level,
      this.time});

  StrategyPost.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            details: data['details'],
            time: data['time'],
            level: data['level'],
            date_time: DateTime.fromMillisecondsSinceEpoch(data['date_time']));

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'time': time,
      'level': level,
      'date_time': date_time?.millisecondsSinceEpoch
    };
  }
}