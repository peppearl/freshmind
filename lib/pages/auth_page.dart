import 'package:flutter/material.dart';
import 'package:freshmind/widgets/login_widget.dart';
import 'package:freshmind/widgets/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LogInWidget(onClickedSignUp: toggle)
        : SignUpWidget(onClickedSignIn: toggle);
  }
}
