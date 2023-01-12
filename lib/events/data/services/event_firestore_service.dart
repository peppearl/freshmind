import 'package:freshmind/db/data_constants.dart';
import 'package:freshmind/events/data/models/event.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

final eventDBS = DatabaseService<Event>(
  AppDBConstants.eventsCollection,
  fromDS: (id, data) => Event.fromDS(id, data),
  toMap: (event) => event.toMap(),
);
