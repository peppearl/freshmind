import 'package:flutter/material.dart';

class GetAppBar extends StatelessWidget {
  const GetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
}
