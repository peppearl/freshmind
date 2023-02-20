import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/components/button_white_text.dart';
import 'package:freshmind/models/recipe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetails extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetails({super.key, required this.recipe});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);
  late bool _isFavorite;
  late bool _planMeal;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.recipe.isFavorite;
    _planMeal = widget.recipe.planMeal;
  }

  @override
  Widget build(BuildContext context) {
    String cheap;
    String vegan;
    String mealPlanButton;

    //cost of the recipe
    if (widget.recipe.cheap) {
      cheap = "Bon marché";
    } else {
      cheap = "Assez cher";
    }

    //is the recipe vegan ?
    if (widget.recipe.vegetarian) {
      vegan = "Végétarien";
    } else {
      vegan = "";
    }

    //remove or add recipe to meal plan
    if (_planMeal) {
      mealPlanButton = "Enlever du planning";
    } else {
      mealPlanButton = "Ajouter au planning";
    }

    return Scaffold(
        body: Column(mainAxisSize: MainAxisSize.min, children: [
      SafeArea(child: AppBarTitle(title: "Ma recette".toUpperCase())),
      Flexible(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              centerTitle: true,
              expandedHeight: 200,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.recipe.image),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: Text(widget.recipe.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, height: 1.5, color: Colors.white)),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
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
                                  widget.recipe.readyInMinutes.toString(),
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
                                  widget.recipe.servings.toString(),
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
                        Chip(
                          label: Text(
                            cheap,
                            style: const TextStyle(color: Color(0xFF73BBB3)),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 220, 241, 238),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Chip(
                          label: Text(widget.recipe.difficulty,
                              style: const TextStyle(
                                color: Color(0xFF73BBB3),
                              )),
                          backgroundColor:
                              const Color.fromARGB(255, 220, 241, 238),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Ingrédients",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ])),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                  child: Row(
                    children: [
                      Text(widget.recipe.ingredients[index]['name']
                          .toString()
                          .capitalizeFirst!),
                      const Spacer(),
                      Text(
                          widget.recipe.ingredients[index]['quantity']
                              .toString(),
                          style: const TextStyle(color: Color(0xFF8A949F))),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.recipe.ingredients[index]['unit'],
                        style: const TextStyle(color: Color(0xFF8A949F)),
                      ),
                    ],
                  ),
                ),
                childCount: widget.recipe.ingredients.length,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ButtonWhiteText(
                                  backgroundColor: const Color(0xFF73BBB3),
                                  title: "Ajouter à la liste de course",
                                  elevation: 0,
                                  onPressed: () {}),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.ideographic,
                              children: [
                                Text(
                                  "Préparation",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${widget.recipe.steps.length} étapes",
                                  style: const TextStyle(
                                      fontSize: 13, color: Color(0xFF8A949F)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ])),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          Text(
                            "Etape ${index + 1}",
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            " /${widget.recipe.steps.length}",
                            style: const TextStyle(
                                fontSize: 10, color: Color(0xFF8A949F)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.recipe.steps[index],
                        style: const TextStyle(color: Color(0xFF8A949F)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                childCount: widget.recipe.steps.length,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isFavorite = !_isFavorite;
                                      FirebaseFirestore.instance
                                          .collection('recipes')
                                          .doc(widget.recipe.id)
                                          .update({
                                        "isFavorite": _isFavorite,
                                      });
                                    });
                                    _controller
                                        .reverse()
                                        .then((value) => _controller.forward());
                                  },
                                  child: ScaleTransition(
                                    scale: Tween(begin: 0.7, end: 1.0).animate(
                                        CurvedAnimation(
                                            parent: _controller,
                                            curve: Curves.easeOut)),
                                    child: _isFavorite
                                        ? Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE4E6E9),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.favorite,
                                              size: 30,
                                              color: Color.fromARGB(
                                                  255, 185, 124, 123),
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE4E6E9),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: const Icon(
                                                Icons.favorite_border,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 185, 124, 123)),
                                          ),
                                  ),
                                ),
                                const Spacer(),
                                ButtonWhiteText(
                                    backgroundColor: const Color.fromARGB(
                                        255, 185, 124, 123),
                                    title: mealPlanButton,
                                    elevation: 0,
                                    onPressed: () {
                                      setState(() {
                                        _planMeal = !_planMeal;
                                        FirebaseFirestore.instance
                                            .collection('recipes')
                                            .doc(widget.recipe.id)
                                            .update({
                                          "planMeal": _planMeal,
                                        });
                                      });
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ])),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
