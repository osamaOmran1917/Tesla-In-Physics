class Lesson {
  static const String collectionName = 'lessons';
  String? id;
  String? name;
  late final level;
  late final number;
  String? media;
  String? details;
  List? content;

  Lesson(
      {this.id,
      this.name,
      this.number,
      this.media,
      this.details,
      this.content,
      this.level});

  Lesson.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            name: data['name'],
            number: data['number'],
            details: data['details'],
            content: data['content'],
            level: data['level'],
            media: data['media']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'number': number,
      'media': media,
      'content': content,
      'level': level
    };
  }
}
