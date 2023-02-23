import 'package:flutter/material.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/components/button_white_text.dart';
import 'package:google_fonts/google_fonts.dart';

class Groceries extends StatefulWidget {
  const Groceries({super.key});

  @override
  State<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const AppBarTitle(title: "MES LISTES DE COURSES"),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nos recommendations",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE4E6E9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "🍉",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Souvent achetés"),
                            Text(
                              "10 produits",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded,
                            size: 30, color: Color(0xFF8A949F)),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Text(
                    "Créés récemment",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE4E6E9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "🍉",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Ajoutés souvent"),
                            Text(
                              "10 produits",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.chevron_right_rounded,
                            size: 30, color: Color(0xFF8A949F)),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: ButtonWhiteText(
                backgroundColor: const Color(0xFF73BBB3),
                title: "Créer une liste de courses",
                elevation: 0,
                onPressed: () {}),
          ),
        ])));
  }
}
