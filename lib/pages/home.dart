import 'package:flutter/material.dart';
import 'package:freshmind/pages/functionnalities_page.dart';
import 'package:freshmind/pages/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 1;

  List iconItems = [
    Icons.person_rounded,
    Icons.home_rounded,
    Icons.groups_rounded,
  ];
  List textItems = ["Profil", "Fonctionnalités", "Groupe"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar(),
      ),
      body: getBody(),
      bottomNavigationBar: bottomAppBar(),
    );
  }

  Widget getAppBar() {
    return AppBar(elevation: 0, backgroundColor: Colors.white, actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search_rounded),
        color: const Color.fromARGB(255, 101, 101, 101),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_rounded),
        color: const Color.fromARGB(255, 101, 101, 101),
      ),
    ]);
  }

  Widget bottomAppBar() {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 5),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(iconItems.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                pageIndex = index;
              });
            },
            child: Column(
              children: [
                Icon(
                  iconItems[index],
                  size: 30,
                  color: pageIndex == index
                      ? const Color.fromARGB(255, 101, 101, 101)
                      : const Color.fromARGB(255, 169, 169, 169),
                ),
                //if text under icons
                /*
                const SizedBox(
                  height: 3,
                ),
                Text(textItems[index],
                    style: TextStyle(
                        color: pageIndex == index
                            ? const Color.fromARGB(255, 101, 101, 101)
                            : const Color.fromARGB(255, 169, 169, 169)))*/
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        Profile(title: "Profil"),
        FunctionnalitiesPage(),
        Center(
          child: Text("Groupe"),
        ),
      ],
    );
  }
}
