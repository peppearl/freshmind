import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Text(
              "FONCTIONNALITÉS",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(color: Color(0xFF899393), offset: Offset(0, -5))
                ],
                color: Colors.transparent,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF73BBB3),
                decorationThickness: 2,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: ListView(children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 4,
                        mainAxisCellCount: 2,
                        child: GridTile(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 185, 124, 123),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 30, 50, 30)),
                                onPressed: () {},
                                child: Center(
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.calendar_month,
                                        size: 50,
                                      ),
                                      Text("Mon planning",
                                          style: TextStyle(
                                              fontSize: 24, height: 1.5))
                                    ],
                                  ),
                                ))),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 3,
                        child: GridTile(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF73BBB3),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 50)),
                                onPressed: () {},
                                child: Center(
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.local_grocery_store_outlined,
                                        size: 50,
                                      ),
                                      Text("Listes de courses",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24, height: 1.5))
                                    ],
                                  ),
                                ))),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 3,
                        child: GridTile(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 185, 124, 123),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 50, 10, 50)),
                                onPressed: () {},
                                child: Center(
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.format_list_bulleted,
                                        size: 50,
                                      ),
                                      Text("To do lists partagées",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24, height: 1.5))
                                    ],
                                  ),
                                ))),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 4,
                        mainAxisCellCount: 2,
                        child: GridTile(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF73BBB3),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        50, 30, 50, 30)),
                                onPressed: () {},
                                child: Center(
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.menu_book_rounded,
                                        size: 50,
                                      ),
                                      Text("Idées de recette",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24, height: 1.5))
                                    ],
                                  ),
                                ))),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 3,
                        child: GridTile(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 185, 124, 123),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 70, 20, 70)),
                                onPressed: () {},
                                child: Center(
                                  child: Column(
                                    children: const <Widget>[
                                      Icon(
                                        Icons.self_improvement_rounded,
                                        size: 50,
                                      ),
                                      Text("Bien-être",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 24, height: 1.5))
                                    ],
                                  ),
                                ))),
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
