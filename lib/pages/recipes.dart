import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/models/recipe.dart';
import 'package:freshmind/pages/recipe_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> with SingleTickerProviderStateMixin {
  //for the tab
  late TabController _tabController;

  late List<Recipe> _recipes;
  late List<Recipe> _favoritesRecipes;
  late List<Recipe> _planMeals;

  //get recipes from firebase
  _loadFirestoreRecipes() async {
    _recipes = [];
    _favoritesRecipes = [];
    _planMeals = [];

    //get all recipes
    final recipes = await FirebaseFirestore.instance
        .collection('recipes')
        .withConverter(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: (recipe, options) => recipe.toFirestore())
        .get();
    final allRecipes = recipes.docs.map((doc) => doc.data()).toList();
    _recipes = allRecipes;

    //get all favorites recipes
    final favoritesRecipes = await FirebaseFirestore.instance
        .collection('recipes')
        .where('isFavorite', isEqualTo: true)
        .withConverter(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: (recipe, options) => recipe.toFirestore())
        .get();
    final allfavoritesRecipes =
        favoritesRecipes.docs.map((doc) => doc.data()).toList();
    _favoritesRecipes = allfavoritesRecipes;

    //get all favorites recipes
    final planMeals = await FirebaseFirestore.instance
        .collection('recipes')
        .where('planMeal', isEqualTo: true)
        .withConverter(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: (recipe, options) => recipe.toFirestore())
        .get();
    final allPlanMeals = planMeals.docs.map((doc) => doc.data()).toList();
    _planMeals = allPlanMeals;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //recipes loaded at the beginning
    _loadFirestoreRecipes();

    //tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //to display all recipes
  List _getRecipes() {
    return _recipes;
  }

  //to display favorites recipes
  List _getFavoritesRecipes() {
    return _favoritesRecipes;
  }

  //to display plan meals
  List _getPlanMeals() {
    return _planMeals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const AppBarTitle(title: "MES RECETTES"),
          tabBar(),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            GridView.count(
              crossAxisCount: 2,
              children: [
                ..._getRecipes().map((recipe) {
                  return GestureDetector(
                      child: Container(
                        height: 150,
                        width: 170,
                        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(recipe.image),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(recipe.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(recipe: recipe))
                            ?.then((_) => {_loadFirestoreRecipes()});
                      });
                }),
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              children: [
                ..._getFavoritesRecipes().map((recipe) {
                  return GestureDetector(
                      child: Container(
                        height: 150,
                        width: 170,
                        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(recipe.image),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(recipe.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(recipe: recipe))
                            ?.then((_) => {_loadFirestoreRecipes()});
                        ;
                      });
                }),
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              children: [
                ..._getPlanMeals().map((recipe) {
                  return GestureDetector(
                      child: Container(
                        height: 150,
                        width: 170,
                        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(recipe.image),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(recipe.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(recipe: recipe))
                            ?.then((_) => {_loadFirestoreRecipes()});
                      });
                }),
              ],
            )
          ])),
        ],
      )),
    );
  }

  tabBar() {
    return TabBar(
      unselectedLabelColor: const Color(0xFF899393),
      labelColor: const Color(0xFF899393),
      labelPadding: const EdgeInsets.only(left: 5, right: 5),
      labelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w300,
      ),
      indicatorColor: const Color(0xFF73BBB3),
      tabs: [
        Tab(
          text: "Catalogue".toUpperCase(),
        ),
        Tab(
          text: "Mes favoris".toUpperCase(),
        ),
        Tab(
          text: "Planning".toUpperCase(),
        ),
      ],
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
