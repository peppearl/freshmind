import 'dart:convert';

class Event {
  final String title;
  final String id;
  final DateTime fromDate;
  final DateTime toDate;
  final String userId;
  final String addedUsers;
  final int color;

  Event(
      {required this.title,
      required this.id,
      required this.fromDate,
      required this.toDate,
      required this.userId,
      required this.addedUsers,
      required this.color});

  Event copyWith({
    required String title,
    required String id,
    required DateTime fromDate,
    required DateTime toDate,
    required String userId,
    required String addedUsers,
    required int color,
  }) {
    return Event(
      title: title,
      id: id,
      fromDate: fromDate,
      toDate: toDate,
      userId: userId,
      addedUsers: addedUsers,
      color: color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
      'userId': userId,
      'addedUsers': addedUsers,
      'color': color,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      id: map['id'],
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate']),
      toDate: DateTime.fromMillisecondsSinceEpoch(map['toDate']),
      userId: map['userId'],
      addedUsers: map['addedUsers'],
      color: map['color'],
    );
  }
  factory Event.fromDS(String id, Map<String, dynamic>? data) {
    return Event(
      title: data!['title'],
      id: id,
      addedUsers: data['addedUsers'],
      fromDate: DateTime.fromMillisecondsSinceEpoch(data['fromDate']),
      toDate: DateTime.fromMillisecondsSinceEpoch(data['toDate']),
      userId: data['user_id'],
      color: data['color'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(title: $title, id: $id, addedUsers: $addedUsers, fromDate: $fromDate, toDate: $toDate, userId: $userId, color: $color)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Event &&
        o.title == title &&
        o.id == id &&
        o.addedUsers == addedUsers &&
        o.fromDate == fromDate &&
        o.toDate == toDate &&
        o.color == color &&
        o.userId == userId;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        addedUsers.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode ^
        color.hashCode ^
        userId.hashCode;
  }
}
