import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:freshmind/pages/auth_page.dart';
import 'package:freshmind/pages/home.dart';
import 'package:freshmind/pages/profile.dart';
import 'package:freshmind/pages/verify_email_page.dart';
import 'package:freshmind/utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      theme: ThemeData().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'FreshMind',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'FreshMind'),
      getPages: <GetPage>[
        GetPage(
            name: '/accueil',
            page: () => const Home(
                  title: 'Accueil',
                )),
        GetPage(
          name: '/recherche',
          page: () => const Center(
            child: Text("Recherche"),
          ),
        ),
        GetPage(
          name: '/notifications',
          page: () => const Center(
            child: Text("Notifications"),
          ),
        ),
        GetPage(name: '/profil', page: () => const Profile(title: "Profil")),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF73BBB3),
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Une erreur s'est produite"));
              } else if (snapshot.hasData) {
                return const VerifyEmailPage();
              } else {
                return const AuthPage();
              }
            }));
  }
}
