class Exam {
  static const String collectionName = 'exams';
  String? id;
  String? notes;
  DateTime? dateTime;
  int? level;

  Exam({this.id, this.notes, this.dateTime, this.level});

  Exam.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            notes: data['notes'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            level: data['level']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'notes': notes,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'level': level
    };
  }
}