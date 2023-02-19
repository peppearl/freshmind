import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  //Alert messages for sign in/sign up
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  //DatePicker
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMMd('fr_FR').format(dateTime);
    final time = DateFormat.Hm('fr_FR').format(dateTime);

    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMMd('fr_FR').format(dateTime);

    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm('fr_FR').format(dateTime);

    return time;
  }
}
