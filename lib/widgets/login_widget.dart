import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/button.dart';
import 'package:freshmind/main.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key});

  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 40,
          ),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: "Email",
                focusColor: Colors.white,
                fillColor: Colors.white),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: "Mot de passe",
                focusColor: Colors.white,
                fillColor: Colors.white),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Button(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: "Se connecter",
              elevation: 2,
              onPressed: signIn)
        ]),
      );

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    // Navigator.of(context) not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
