import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/components/get_app_bar.dart';
import 'package:freshmind/pages/add_event.dart';
import 'package:freshmind/pages/add_event_task.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  String locale = "fr";
  late DateFormat timeFormat;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;

    initializeDateFormatting(locale).then((_) => setState(() {}));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        print(selectedDay.toIso8601String());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: GetAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarTitle(title: "MON PLANNING"),
            _addDateBar(),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        children: [
          SpeedDialChild(
              //speed dial child
              child: const Icon(Icons.accessibility),
              backgroundColor: const Color(0xFF73BBB3),
              foregroundColor: Colors.white,
              label: 'Evènement',
              labelBackgroundColor: Colors.transparent,
              labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
              onTap: () => showModalEvent(),
              labelShadow: [const BoxShadow(color: Colors.transparent)]),
          SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: const Color.fromARGB(255, 185, 124, 123),
              foregroundColor: Colors.white,
              labelBackgroundColor: Colors.transparent,
              label: 'Tâches',
              labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
              onTap: () => showModalTask(),
              labelShadow: [const BoxShadow(color: Colors.transparent)]),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      color: const Color(0xFF73BBB3),
      height: 430,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 20),
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2022, 10, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            locale: 'fr',
            //onDaySelected: _onDaySelected,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 185, 124, 123),
                  shape: BoxShape.circle),
              selectedDecoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            ),
            headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white),
                formatButtonVisible: false,
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )),
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected
            /*(date, events) {
              print(date.toIso8601String());
            },*/
            ,
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Text(date.day.toString())),
              todayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(6),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 185, 124, 123),
                      shape: BoxShape.circle),
                  child: Text(date.day.toString())),
            ),
          )
        ]),
      ),
    );
  }

  showModalEvent() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 16,
            child: AddEvent(selectedDate: _selectedDay));
      });

  showModalTask() => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 16,
            child: AddEventTask(selectedDate: _selectedDay));
      });
}
