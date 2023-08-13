class Exam {
  static const String collectionName = 'exams';
  String? id;
  int? level;
  String? image;
  String? notes;
  String? student_id;

  Exam({this.id, this.image, this.student_id, this.notes, this.level});

  Exam.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            level: data['level'],
            image: data['image'],
            notes: data['notes'],
            student_id: data['student_id']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'level': level,
      'image': image,
      'notes': notes,
      'student_id': student_id,
    };
  }
}