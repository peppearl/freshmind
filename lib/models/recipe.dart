import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  final String title;
  final String id;
  final String difficulty;
  final bool cheap;
  final bool isFavorite;
  final bool planMeal;
  final int cookingTime;
  final String image;
  /* final List<Ingredient> ingredients; */
  final int preparationTime;
  final int readyInMinutes;
  final int servings;
  final List<String> steps;
  final bool vegetarian;

  Recipe(
      {required this.title,
      required this.id,
      required this.difficulty,
      required this.cheap,
      required this.isFavorite,
      required this.planMeal,
      required this.cookingTime,
      required this.image,
      /* required this.ingredients, */
      required this.preparationTime,
      required this.readyInMinutes,
      required this.servings,
      required this.steps,
      required this.vegetarian});

  factory Recipe.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      [SnapshotOptions? options]) {
    final data = snapshot.data()!;
    return Recipe(
      title: data['title'],
      id: snapshot.id,
      difficulty: data['difficulty'],
      cheap: data['cheap'],
      planMeal: data['planMeal'],
      isFavorite: data['isFavorite'],
      cookingTime: data['cookingTime'],
      image: data['image'],
      /*ingredients: List<Ingredient>.from(
          data["ingredients"].map((x) => Ingredient.fromFirestore(x))), */
      preparationTime: data['preparationTime'],
      readyInMinutes: data['readyInMinutes'],
      servings: data['servings'],
      vegetarian: data['vegetarian'],
      steps: List.from(data['steps']),
    );
  }

  Map<String, Object?> toFirestore() {
    return {
      'title': title,
      'id': id,
      'difficulty': difficulty,
      'cheap': cheap,
      'isFavorite': isFavorite,
      'planMeal': planMeal,
      'cookingTime': cookingTime,
      'image': image,
      /* 'ingredients': ingredients, */
      'preparationTime': preparationTime,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'vegetarian': vegetarian,
      'steps': steps,
    };
  }
}
