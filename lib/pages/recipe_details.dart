import 'package:flutter/material.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/models/recipe.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetails({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(child: AppBarTitle(title: "Mes recettes".toUpperCase())),
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(recipe.image), fit: BoxFit.cover),
            ),
            child: Center(
              child: Text(recipe.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, height: 1.5, color: Colors.white)),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Ingrédients pour ${recipe.servings}")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
