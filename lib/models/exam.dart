class Exam {
  static const String collectionName = 'exams';
  String? id;
  String? image;
  String? student_id;

  Exam({this.id, this.image, this.student_id});

  Exam.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            image: data['image'],
            student_id: data['student_id']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'image': image,
      'student_id': student_id,
    };
  }
}
