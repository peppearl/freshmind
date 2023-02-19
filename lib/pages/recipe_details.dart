import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/models/recipe.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;
  final List<dynamic> ingredients;
  const RecipeDetails(
      {super.key, required this.recipe, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    String cheap;
    String vegan;
    late List<dynamic> _ingredient_name;

    //cost of the recipe
    if (recipe.cheap) {
      cheap = "Bon marché";
    } else {
      cheap = "Assez cher";
    }

    //is the recipe vegan ?
    if (recipe.vegetarian) {
      vegan = "Végétarien";
    } else {
      vegan = "";
    }

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(child: AppBarTitle(title: "Mes recettes".toUpperCase())),
          /*Container(
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
          ),*/
          Flexible(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  expandedHeight: 200,
                  flexibleSpace: Container(
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
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                    color: const Color(0xFFD9D9D9),
                                    width: 1.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      recipe.readyInMinutes.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          color: const Color.fromARGB(
                                              255, 185, 124, 123)),
                                    ),
                                    const Text("minutes")
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      recipe.servings.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          color: const Color.fromARGB(
                                              255, 185, 124, 123)),
                                    ),
                                    const Text("personnes")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Wrap(
                          children: [
                            Chip(label: Text(cheap)),
                            const SizedBox(
                              width: 10,
                            ),
                            Chip(
                              label: Text(recipe.difficulty),
                            ),
                          ],
                        ),
                        const Text("Ingrédients"),
                      ],
                    ),
                  ),
                ])),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          Text(ingredients[index]["name"]
                              .toString()
                              .replaceAll(RegExp(r'[^\w\s]+'), '')),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(ingredients[index]['quantity'].toString()),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(ingredients[index]['unit']),
                        ],
                      ),
                    ),
                    childCount: ingredients.length,
                  ),
                ),
              ],
            ),
          ),
          /*
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                              color: const Color(0xFFD9D9D9), width: 1.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                recipe.readyInMinutes.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromARGB(
                                        255, 185, 124, 123)),
                              ),
                              const Text("minutes")
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                recipe.servings.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromARGB(
                                        255, 185, 124, 123)),
                              ),
                              const Text("personnes")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Wrap(
                    children: [
                      Chip(label: Text(cheap)),
                      const SizedBox(
                        width: 10,
                      ),
                      Chip(
                        label: Text(recipe.difficulty),
                      ),
                    ],
                  ),
                  const Text("Ingrédients"),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            //Text(ingredients[index]['name'].toString()),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(ingredients[index]['quantity'].toString()),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(ingredients[index]['unit']),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ) */
        ],
      ),
    );
  }
}
