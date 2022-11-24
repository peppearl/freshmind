import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/button.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Connecté en tant que "),
              const SizedBox(height: 8),
              Text(user.email!),
              Button(
                  backgroundColor: const Color(0xFF73BBB3),
                  foregroundColor: Colors.white,
                  title: "Se déconnecter",
                  elevation: 0,
                  onPressed: () => FirebaseAuth.instance.signOut())
            ],
          ),
        ));
  }
}
