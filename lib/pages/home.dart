import 'package:flutter/material.dart';
import 'package:freshmind/components/get_app_bar.dart';
import 'package:freshmind/pages/functionnalities_page.dart';
import 'package:freshmind/pages/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PersistentTabController _controller;
  late bool _hideNavBar;

  //different routes of bottom nav bar
  List<Widget> _buildScreens() {
    return const [
      SafeArea(child: FunctionnalitiesPage()),
      Center(
        child: Text("Recherche"),
      ),
      Center(
        child: Text("Notifications"),
      ),
      Profile(title: "Profil"),
    ];
  }

  //different icons of bottom nav bar
  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          inactiveColorPrimary: const Color.fromARGB(255, 169, 169, 169),
          activeColorPrimary: const Color.fromARGB(255, 101, 101, 101)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.search_rounded),
          inactiveColorPrimary: const Color.fromARGB(255, 169, 169, 169),
          activeColorPrimary: const Color.fromARGB(255, 101, 101, 101)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications_rounded),
          inactiveColorPrimary: const Color.fromARGB(255, 169, 169, 169),
          activeColorPrimary: const Color.fromARGB(255, 101, 101, 101)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_rounded),
          inactiveColorPrimary: const Color.fromARGB(255, 169, 169, 169),
          activeColorPrimary: const Color.fromARGB(255, 101, 101, 101)),
    ];
  }

  @override
  void initState() {
    super.initState();
    _hideNavBar = false;
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      navBarHeight: 60,
      items: _navBarItems(),
      navBarStyle: NavBarStyle.simple,
      controller: _controller,
    );
  }
}
