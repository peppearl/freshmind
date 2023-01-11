import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetBackAppBar extends StatelessWidget {
  const GetBackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 101, 101, 101)),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: const Color.fromARGB(255, 101, 101, 101),
          ),
        ]);
  }
}
