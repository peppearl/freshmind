import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String id;
  final String name;
  final int quantity;
  final String unit;

  Ingredient(
      {required this.id,
      required this.name,
      required this.unit,
      required this.quantity});

  factory Ingredient.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Ingredient(
      name: data['name'],
      id: snapshot.id,
      unit: data['user_id'],
      quantity: data['quantity'],
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      'name': name,
      'id': id,
      'unit': unit,
      'quantity': quantity,
    };
  }
}
