class Lesson {
  static const String collectionName = 'lessons';
  String? id;
  String? name;
  String? number;
  String? image;

  Lesson({this.id, this.name, this.number, this.image});

  Lesson.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            name: data['name'],
            number: data['number'],
            image: data['image']);

  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'number': number, 'image': image};
  }
}
