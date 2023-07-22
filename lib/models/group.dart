class Group {
  static const String collectionName = 'groups';
  String? id;
  bool? saturday;
  bool? sunday;
  bool? monday;
  bool? tuesday;
  bool? wednesday;
  bool? thursday;
  bool? friday;
  String? time;
  String? duration;
  int? level;

  Group(
      {this.id,
      this.saturday,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.time,
      this.duration,
      this.level});

/*Group.fromFirestore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            notes: data['notes'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            level: data['level']);*/

/*Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'notes': notes,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'level': level
    };
  }*/
}
