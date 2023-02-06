import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/button_green_text.dart';
import 'package:freshmind/main.dart';
import 'package:freshmind/pages/forgot_password_page.dart';
import 'package:freshmind/utils.dart';
import 'package:google_fonts/google_fonts.dart';

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
          const Image(
              image: AssetImage('assets/images/freshmind-logo.png'), width: 75),
          const SizedBox(
            height: 10,
          ),
          Text("FRESHMIND",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 37,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w900)),
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
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 10,
                  offset: const Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: emailController,
              cursorColor: const Color(0xFF8B8B8B),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(
                  color: Color(0xFF8B8B8B),
                ),
                focusColor: Colors.white,
                fillColor: const Color(0xFFAFDBD6),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 10,
                  offset: const Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: passwordController,
              cursorColor: const Color(0xFF8B8B8B),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                labelStyle: const TextStyle(
                  color: Color(0xFF8B8B8B),
                ),
                focusColor: Colors.white,
                fillColor: const Color(0xFFAFDBD6),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 20),
          ButtonGreenText(
              backgroundColor: Colors.white,
              title: "Je me connecte",
              elevation: 2,
              onPressed: signIn),
          const SizedBox(height: 24),
          GestureDetector(
            child: const Text(
              "J'ai oublié mon mot de passe",
              style: TextStyle(
                  fontSize: 12,
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
      Utils.showSnackBar(e.message);
    }

    // Navigator.of(context) not working
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
