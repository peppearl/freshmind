import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Event.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Event(
      title: data['title'],
      id: snapshot.id,
      fromDate: DateTime.fromMillisecondsSinceEpoch(data['fromDate']),
      toDate: DateTime.fromMillisecondsSinceEpoch(data['toDate']),
      userId: data['user_id'],
      color: data['color'],
      addedUsers: data['addedUsers'],
    );
  }

  Map<String, Object?> toFirestore() {
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
}
