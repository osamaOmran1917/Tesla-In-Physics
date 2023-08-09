class Exam {
  static const String collectionName = 'exams';
  String? id;
  String? image;
  String? notes;
  String? student_id;

  Exam({this.id, this.image, this.student_id, this.notes});

  Exam.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            image: data['image'],
            notes: data['notes'],
            student_id: data['student_id']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'image': image,
      'notes': notes,
      'student_id': student_id,
    };
  }
}
