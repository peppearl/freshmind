import 'dart:convert';

class Event {
  final String title;
  final String id;
  final DateTime date;
  final String userId;
  final String addedUsers;

  Event(
      {required this.title,
      required this.id,
      required this.date,
      required this.userId,
      required this.addedUsers});

  Event copyWith({
    required String title,
    required String id,
    required DateTime date,
    required String userId,
    required String addedUsers,
  }) {
    return Event(
      title: title,
      id: id,
      date: date,
      userId: userId,
      addedUsers: addedUsers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'userId': userId,
      'addedUsers': addedUsers,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'],
      addedUsers: map['addedUsers'],
    );
  }
  factory Event.fromDS(String id, Map<String, dynamic> data) {
    return Event(
      title: data['title'],
      id: id,
      addedUsers: data['addedUsers'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      userId: data['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(title: $title, id: $id, addedUsers: $addedUsers, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Event &&
        o.title == title &&
        o.id == id &&
        o.addedUsers == addedUsers &&
        o.date == date &&
        o.userId == userId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        addedUsers.hashCode ^
        date.hashCode ^
        userId.hashCode;
  }
}
