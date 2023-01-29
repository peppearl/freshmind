import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/events/data/models/event.dart';
import 'package:freshmind/pages/add_event.dart';
import 'package:freshmind/pages/add_event_task.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  //set locale to french
  String locale = "fr";
  late DateFormat timeFormat;

  //calendar
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;

  //for the tab
  late TabController _tabController;

  //to provide events in calendar
  late Map<DateTime, List<Event>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  //get events from firebase
  _loadFirestoreEvents() async {
    final firstDay =
        DateTime(_focusedDay.year, _focusedDay.month, 1).millisecondsSinceEpoch;
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0)
        .millisecondsSinceEpoch;
    _events = {};

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('fromDate', isGreaterThanOrEqualTo: firstDay)
        .where('fromDate', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day = DateTime.utc(
          event.fromDate.year, event.fromDate.month, event.fromDate.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    //calendar
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now();
    _lastDay = _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();

    //events loaded at the beginning
    _loadFirestoreEvents();

    //tabs
    _tabController = TabController(length: 2, vsync: this);

    //locale
    initializeDateFormatting(locale).then((_) => setState(() {}));

    //to provide events in calendar
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
  }

  //to display event markers
  List _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          const AppBarTitle(title: "MON PLANNING"),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: const Color(0xFF73BBB3),
                  height: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    //eventLoader: _getEventsForTheDay,
                    locale: 'fr',
                    calendarStyle: const CalendarStyle(
                      disabledTextStyle: TextStyle(color: Color(0xFF629E98)),
                      defaultTextStyle: TextStyle(color: Colors.white),
                      outsideDaysVisible: false,
                      selectedTextStyle:
                          TextStyle(color: Color.fromARGB(255, 185, 124, 123)),
                      todayDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 124, 123),
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
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
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                      _loadFirestoreEvents();
                    },
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                  ),
                ),
                tabBar(),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  ListView(
                    children: [
                      ..._getEventsForTheDay(_selectedDay).map(
                        (event) => ListTile(
                          title: Text(
                            event.title,
                          ),
                          subtitle: Text(
                            event.fromDate.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      ..._getEventsForTheDay(_selectedDay).map(
                        (event) => ListTile(
                          title: Text(
                            event.title,
                          ),
                          subtitle: Text(
                            event.fromDate.toString(),
                          ),
                        ),
                      ),
                    ],
                  )
                ])),
              ],
            ),
          ),
        ],
      )),
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
              onTap: () async {
                final result =
                    await Get.to(() => AddEvent(selectedDate: _selectedDay));
                if (result ?? false) {
                  _loadFirestoreEvents();
                }
              },
              labelShadow: [const BoxShadow(color: Colors.transparent)]),
          SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: const Color.fromARGB(255, 185, 124, 123),
              foregroundColor: Colors.white,
              labelBackgroundColor: Colors.transparent,
              label: 'Tâches',
              labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
              onTap: () async {
                final result = await Get.to(
                    () => AddEventTask(selectedDate: _selectedDay));
                if (result ?? false) {
                  _loadFirestoreEvents();
                }
              },
              labelShadow: [const BoxShadow(color: Colors.transparent)]),
        ],
      ),
    );
  }

  tabBar() {
    String formattedSelectedDate;
    //convert date to string for comparisons
    String dateNow = DateFormat("d MMMM", "fr_FR").format(DateTime.now());
    String selectedDate = DateFormat("d MMMM", "fr_FR").format(_selectedDay);

    //either show today or date for selected date in tab bar
    if (dateNow == selectedDate) {
      formattedSelectedDate = "Aujourd'hui";
    } else {
      formattedSelectedDate =
          DateFormat("d MMMM", "fr_FR").format(_selectedDay);
    }
    return TabBar(
      unselectedLabelColor: const Color(0xFFD9DBDB),
      labelColor: const Color.fromARGB(255, 185, 124, 123),
      indicatorColor: Colors.transparent,
      isScrollable: true,
      tabs: [
        Tab(
          text: formattedSelectedDate,
        ),
        const Tab(
          text: "Ce mois-ci",
        )
      ],
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
