import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/pages/calendar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class FunctionnalitiesPage extends StatefulWidget {
  const FunctionnalitiesPage({super.key});

  @override
  State<FunctionnalitiesPage> createState() => _FunctionnalitiesPageState();
}

class _FunctionnalitiesPageState extends State<FunctionnalitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const AppBarTitle(
            title: 'Fonctionnalités',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: ListView(children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 4,
                        mainAxisCellCount: 2,
                        child: GridTile(
                            child: GestureDetector(
                                child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/mon-planning-bouton.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.calendar_month,
                                            size: 50, color: Colors.white),
                                        Text("Mon planning",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                      ],
                                    ) // button text
                                    ),
                                onTap: () =>
                                    PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const Calendar(),
                                        //screen: const Calendar2(),
                                        withNavBar: true))),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: GridTile(
                            child: GestureDetector(
                                child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/bien-etre.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.self_improvement_rounded,
                                            size: 50, color: Colors.white),
                                        Text("Mes astuces",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                        Text("bien-être",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                      ],
                                    ) // button text
                                    ),
                                onTap: () => {})),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 3,
                        child: GridTile(
                            child: GestureDetector(
                                child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/listes-course.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.shopping_basket_rounded,
                                            size: 50, color: Colors.white),
                                        Text("Mes listes",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                        Text("de course",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                      ],
                                    ) // button text
                                    ),
                                onTap: () => {})),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 3,
                        child: GridTile(
                            child: GestureDetector(
                                child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/recette.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.menu_book_rounded,
                                            size: 50, color: Colors.white),
                                        Text("Mes recettes",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                      ],
                                    ) // button text
                                    ),
                                onTap: () => {})),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: GridTile(
                            child: GestureDetector(
                                child: Container(
                                    width: 120,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/to-do-list.png"),
                                          fit: BoxFit.cover),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.checklist_rounded,
                                            size: 50, color: Colors.white),
                                        Text("Mes to do lists",
                                            style: TextStyle(
                                                fontSize: 16,
                                                height: 1.5,
                                                color: Colors.white)),
                                      ],
                                    ) // button text
                                    ),
                                onTap: () => {})),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
