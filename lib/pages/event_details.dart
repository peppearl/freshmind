import 'package:flutter/material.dart';
import 'package:freshmind/events/data/models/event.dart';
import 'package:freshmind/events/data/services/event_firestore_service.dart';
import 'package:freshmind/pages/add_event.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    //know if this is an event or a task
    String eventType;

    if (event.color == 4285774771) {
      eventType = "l'évènement";
    } else {
      eventType = "la tâche";
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          heightFactor: 0.5,
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.close,
              size: 24,
              color: Color(0xFF899393),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          height: 300,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.calendar_month,
                      size: 24, color: Color(event.color)),
                  const SizedBox(width: 10),
                  Text(event.title.toUpperCase(),
                      style: TextStyle(
                          color: Color(event.color),
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts.poppins().toString()))
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.schedule, size: 24, color: Color(event.color)),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat("d MMMM à HH:mm", "fr_FR")
                        .format(event.fromDate),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.notifications_active_outlined,
                      size: 24, color: Color(event.color)),
                  const SizedBox(width: 10),
                  const Text("Rappel deux jours avant")
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(event.color),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.only(left: 0, right: 0)),
                onPressed: () {},
                child: MaterialButton(
                  onPressed: () => Get.to(() => AddEvent(
                        event: event,
                      )),
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    "Modifier $eventType",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: GestureDetector(
                  child: Text(
                    "Supprimer",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Color(event.color)),
                  ),
                  onTap: () {
                    eventDBS.removeItem(event.id);
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
