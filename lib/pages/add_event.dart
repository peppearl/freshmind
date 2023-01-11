import 'package:flutter/material.dart';
import 'package:freshmind/components/center_title.dart';
import 'package:freshmind/components/get_back_app_bar.dart';
import 'package:freshmind/components/input_field.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: GetBackAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CenterTitle(title: "AJOUTER UN EVENEMENT"),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  MyInputField(
                      title: "Nom de l'évènement",
                      hint: "Entre le nom de l'évènement")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
