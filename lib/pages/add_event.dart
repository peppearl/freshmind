import 'package:flutter/material.dart';
import 'package:freshmind/components/center_title.dart';
import 'package:freshmind/components/get_back_app_bar.dart';
import 'package:freshmind/components/input_field.dart';
import 'package:freshmind/components/input_field_icon.dart';
import 'package:freshmind/utils.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();

  late DateTime fromDate;
  late DateTime toDate;

  late TextEditingController fromDateController = TextEditingController(),
      endDateController = TextEditingController(),
      beginTimeController = TextEditingController(),
      endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fromDate = DateTime.now();
    toDate = DateTime.now().add(const Duration(hours: 1));

    //initialize date and time to today's date + 1 hour
    fromDateController.text = Utils.toDate(fromDate);
    endDateController.text = Utils.toDate(toDate);
    beginTimeController.text = Utils.toTime(fromDate);
    endTimeController.text = Utils.toTime(toDate);
  }

  //DateTime? startTime, endTime;

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2999),
    );
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyInputField(
                      title: "Nom de l'évènement",
                      hint: "Entre le nom de l'évènement",
                      textColor: Color(0xFF73BBB3),
                    ),
                    const SizedBox(height: 20),
                    buildDateTimePickers(),
                    const SizedBox(height: 20),
                    const InputFieldIcon(
                        title: "Ajouter des personnes à l'évènement",
                        hint: "Invite une personne",
                        textColor: Color(0xFF73BBB3))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          const SizedBox(height: 10),
          buildTo(),
        ],
      );

  Widget buildFrom() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "de",
                  style: TextStyle(color: Color.fromARGB(255, 185, 124, 123)),
                ),
                TextFormField(
                  controller: fromDateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'Date de début',
                    hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B),
                    ),
                    focusColor: Colors.white,
                  ),
                  onTap: () async {
                    await pickFromDateTime(pickDate: true);
                    fromDateController.text = Utils.toDate(fromDate);
                    //in case from date is after to date
                    endDateController.text = Utils.toDate(toDate);
                    setState(() {});
                  },
                  readOnly: true,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "",
                  style: TextStyle(color: Color.fromARGB(255, 185, 124, 123)),
                ),
                TextFormField(
                  controller: beginTimeController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'Heure de début',
                    hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                  onTap: () async {
                    await pickFromDateTime(pickDate: false);
                    if (toDate.isBefore(fromDate)) {
                      fromDate = toDate.subtract(const Duration(hours: 1));
                    }
                    beginTimeController.text = Utils.toTime(fromDate);
                    setState(() {});
                  },
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildTo() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "à",
                  style: TextStyle(color: Color.fromARGB(255, 185, 124, 123)),
                ),
                TextFormField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'Date de fin',
                    hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B),
                    ),
                    focusColor: Colors.white,
                  ),
                  onTap: () async {
                    await pickToDateTime(pickDate: true);
                    endDateController.text = Utils.toDate(toDate);
                    setState(() {});
                  },
                  readOnly: true,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "",
                  style: TextStyle(color: Color.fromARGB(255, 185, 124, 123)),
                ),
                TextFormField(
                  controller: endTimeController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'Heure de fin',
                    hintStyle: TextStyle(
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                  onTap: () async {
                    await pickToDateTime(pickDate: false);
                    if (toDate.isBefore(fromDate)) {
                      toDate = fromDate.add(const Duration(hours: 1));
                    }
                    endTimeController.text = Utils.toTime(toDate);
                    setState(() {});
                  },
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      );

  //start of event pick date and time
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  //end of event pick date and time
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  //show date and time picker
  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        locale: const Locale("fr", "FR"),
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2018, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
        builder: (context, child) {
          return Localizations.override(
            context: context,
            locale: const Locale("fr", "FR"),
            child: child,
          );
        },
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }
}
