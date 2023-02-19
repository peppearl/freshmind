import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  //get auth user info
  final FirebaseAuth auth = FirebaseAuth.instance;

  //to provide events in calendar
  late List<Recipe> _recipes;
  late List<dynamic> _ingredients;
  late List<dynamic> _ingredient_name;

  //get events from firebase
  _loadFirestoreEvents() async {
    _recipes = [];
    _ingredients = [];
    _ingredient_name = [];

    //get all events of current user
    final recipes = await FirebaseFirestore.instance
        .collection('recipes')
        .withConverter(
            fromFirestore: Recipe.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    final allRecipes = recipes.docs.map((doc) => doc.data()).toList();
    _recipes = allRecipes;

    for (var doc in recipes.docs) {
      final ingredients = doc["ingredients"].toList();
      _ingredients = ingredients;
      //print(_ingredients);

      for (var i = 0; i < ingredients.length; i++) {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection("ingredients")
            .doc(ingredients[i]["ingredient_id"]);
        documentReference.get().then((datasnapshot) {
          if (datasnapshot.exists) {
            //print(datasnapshot.data());
            //ingredients[i]["name"] = datasnapshot.data();
            //print(datasnapshot.data());
            Map<dynamic, dynamic>? map = datasnapshot.data() as Map?;
            var test = map?.values.toList();
            ingredients[i]["name"] = test;
            print(ingredients[i]["name"]);
          }
        });

        /*
      documentReference.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          print(datasnapshot.data().toString());
        } else {
          print("No such user");
        }
      });*/
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //events loaded at the beginning
    _loadFirestoreEvents();

    //tabs
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //to display event markers
  List _getRecipes() {
    return _recipes;
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
                ..._getRecipes().map((event) {
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
                              image: NetworkImage(event.image),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(event.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(
                            recipe: event, ingredients: _ingredients));
                      });
                }),
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              children: [
                ..._getRecipes().map((event) {
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
                              image: NetworkImage(event.image),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(event.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(
                            recipe: event, ingredients: _ingredients));
                      });
                }),
              ],
            ),
            GridView.count(
              crossAxisCount: 2,
              children: [
                ..._getRecipes().map((event) {
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
                              image: NetworkImage(event.image),
                              fit: BoxFit.cover),
                        ),
                        child: Center(
                          child: Text(event.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                  color: Colors.white)),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RecipeDetails(
                            recipe: event, ingredients: _ingredients));
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
          text: "Pour le dîner".toUpperCase(),
        ),
      ],
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
