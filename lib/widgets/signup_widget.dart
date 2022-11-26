import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freshmind/components/button.dart';
import 'package:freshmind/main.dart';
import 'package:freshmind/utils.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpWidget({super.key, required this.onClickedSignIn});

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late bool passwordVisibility = false;
  late bool confirmPasswordVisibility = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 40,
          ),
          const Text("S'identifier",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
                labelText: "Email",
                focusColor: Colors.white,
                fillColor: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? "Veuillez indiquer une adresse e-mail valide"
                    : null,
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: "Mot de passe",
              focusColor: Colors.white,
              fillColor: Colors.white,
              suffixIcon: InkWell(
                onTap: () => setState(
                  () => passwordVisibility = !passwordVisibility,
                ),
                focusNode: FocusNode(skipTraversal: true),
                child: Icon(
                  passwordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color.fromARGB(255, 84, 84, 84),
                  size: 22,
                ),
              ),
            ),
            obscureText: !passwordVisibility,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => value != null && value.length < 6
                ? "Le mot de passe doit comporter au moins six caractères"
                : null,
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: confirmPasswordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: "Confirmer le mot de passe",
              focusColor: Colors.white,
              fillColor: Colors.white,
              suffixIcon: InkWell(
                onTap: () => setState(
                  () => confirmPasswordVisibility = !confirmPasswordVisibility,
                ),
                focusNode: FocusNode(skipTraversal: true),
                child: Icon(
                  confirmPasswordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color.fromARGB(255, 84, 84, 84),
                  size: 22,
                ),
              ),
            ),
            obscureText: !confirmPasswordVisibility,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value != null && value.length < 6) {
                return "Le mot de passe doit comporter au moins six caractères";
              } else if (value != passwordController.text) {
                return "Mots de passe différents";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          Button(
              backgroundColor: Colors.white,
              title: "M'inscrire",
              elevation: 2,
              onPressed: signUp),
          const SizedBox(height: 24),
          RichText(
              text: TextSpan(text: "Déjà un compte ?  ", children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignIn,
                text: "Se connecter",
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold))
          ]))
        ]),
      ));

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
