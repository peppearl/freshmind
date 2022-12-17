import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/button_white_text.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Connecté en tant que "),
          const SizedBox(height: 8),
          Text(user.email!),
          ButtonWhiteText(
              backgroundColor: const Color(0xFF73BBB3),
              title: "Se déconnecter",
              elevation: 0,
              onPressed: () => FirebaseAuth.instance.signOut())
        ],
      ),
    ));
  }
}
