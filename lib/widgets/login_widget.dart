import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/button.dart';
import 'package:freshmind/main.dart';
import 'package:freshmind/pages/forgot_password_page.dart';
import 'package:freshmind/utils.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({super.key, required this.onClickedSignUp});

  final VoidCallback onClickedSignUp;

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
          const Text("Connexion",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
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
              title: "Me connecter",
              elevation: 2,
              onPressed: signIn),
          const SizedBox(height: 24),
          GestureDetector(
            child: const Text(
              "Mot de passe oublié ?",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            )),
          ),
          const SizedBox(height: 16),
          RichText(
              text: TextSpan(text: "Nouveau sur FreshMind ?  ", children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignUp,
                text: "Créer un compte",
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold))
          ]))
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

      Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
