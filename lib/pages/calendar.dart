import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/components/get_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String locale = "fr";
  late DateFormat timeFormat;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting(locale).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: GetAppBar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarTitle(title: "MON PLANNING"),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd(locale).format(DateTime.now())),
                const Text("Aujourd'hui"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color.fromARGB(255, 185, 124, 123),
              selectedTextColor: Colors.white,
              dateTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF73BBB3)),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => {},
        child: const Icon(Icons.add, color: Colors.grey),
        /*
        onPressed: () {
          _showSimpleModalDialog(context);
        },
        */
      ),
    );
  }
}
