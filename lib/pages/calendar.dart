import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/events/data/models/event.dart';
import 'package:freshmind/events/data/services/event_firestore_service.dart';
import 'package:freshmind/pages/add_event.dart';
import 'package:freshmind/pages/add_event_task.dart';
import 'package:freshmind/pages/event_details.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    Key? key,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  String locale = "fr";
  late DateFormat timeFormat;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  final FirebaseAuth auth = FirebaseAuth.instance;

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    _selectedDay = _focusedDay;

    initializeDateFormatting(locale).then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  //get minutes in hh:mm
  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")}h${minutes.toString().padLeft(2, "0")}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: GetAppBar(),
      ),
      */
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarTitle(title: "MON PLANNING"),
            _addDateBar(),
            tabBar(),
            tabBarView(),
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
              onTap: () => Get.to(() => AddEvent(selectedDate: _selectedDay)),
              labelShadow: [const BoxShadow(color: Colors.transparent)]),
          SpeedDialChild(
              child: const Icon(Icons.brush),
              backgroundColor: const Color.fromARGB(255, 185, 124, 123),
              foregroundColor: Colors.white,
              labelBackgroundColor: Colors.transparent,
              label: 'Tâches',
              labelStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
              onTap: () =>
                  Get.to(() => AddEventTask(selectedDate: _selectedDay)),
              labelShadow: [const BoxShadow(color: Colors.transparent)]),
        ],
      ),
    );
  }

  //calendar
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
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2024, 12, 31),
            locale: 'fr',
            calendarStyle: const CalendarStyle(
              disabledTextStyle: TextStyle(color: Color(0xFF629E98)),
              defaultTextStyle: TextStyle(color: Colors.white),
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

  //tab bar title
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

  //tab bar content
  tabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          showEvents(true),
          showEvents(false),
        ],
      ),
    );
  }

  //showing events
  showEvents(bool daySelected) {
    //get user id of the current user
    final User? user = auth.currentUser;
    final userid = user?.uid;

    if (daySelected) {
      return const Text("test");
    } else {
      return StreamBuilder(
        stream: eventDBS.streamQueryList(args: [
          //show only the events created by current user
          QueryArgsV2("user_id", isEqualTo: userid.toString()),
        ]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data;

            return ListView.builder(
                itemCount: events.length,
                itemBuilder: (BuildContext context, int index) {
                  Event event = events[index];
                  DateTime date = event.fromDate;

                  //know if this is an event or a task
                  String eventType;

                  if (event.color == 4285774771) {
                    eventType = "Evènement dans";
                  } else {
                    eventType = "Tâche à accomplir dans";
                  }

                  //getting the difference between now time and the event time
                  int difference = date.difference(DateTime.now()).inMinutes;

                  String time = getTimeString(difference);
                  final String stringDate;

                  //convert date to string for comparisons
                  String dateNow =
                      DateFormat("d MMMM", "fr_FR").format(DateTime.now());
                  String eventDate = DateFormat("d MMMM", "fr_FR").format(date);

                  //today in the future
                  if (!time.contains('-') && dateNow == eventDate) {
                    stringDate = "$eventType $time";
                  }
                  //today in the past
                  else if (time.contains('-') && dateNow == eventDate) {
                    String formattedDate =
                        DateFormat("HH : mm", 'fr_FR').format(date);
                    stringDate = "Aujourd'hui, $formattedDate";
                  } /*else if (!time.contains('-') && daySelected == false) {
                  stringDate = "Evènement dans $time futur";
                } */
                  //date in the future or past but not today
                  else {
                    String formattedDate =
                        DateFormat("d MMMM à HH:mm", 'fr_FR').format(date);
                    stringDate = "Le $formattedDate";
                  }

                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text(stringDate),
                    //onTap: () => Get.to(() => EventDetails(event: event)),
                    onTap: () => showModalEventDetails(event),
                  );
                });
          }
          return const CircularProgressIndicator();
        },
      );
    }
  }

  showModalEventDetails(event) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 16,
            child: EventDetails(event: event));
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
