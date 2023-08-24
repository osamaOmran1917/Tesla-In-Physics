class Lesson {
  static const String collectionName = 'lessons';
  String? id;
  String? name;
  late var number;
  String? media;
  String? details;
  String? content;

  Lesson(
      {this.id,
      this.name,
      this.number,
      this.media,
      this.details,
      this.content});

  Lesson.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            name: data['name'],
            number: data['number'],
            details: data['details'],
            content: data['content'],
            media: data['image']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'details': details,
      'number': number,
      'image': media,
      'content': content,
    };
  }
}
