import 'package:flutter/material.dart';
import 'package:freshmind/components/button_white_text.dart';
import 'package:freshmind/components/input_field.dart';
import 'package:freshmind/components/input_field_icon.dart';
import 'package:freshmind/utils.dart';

class AddEventTask extends StatefulWidget {
  final DateTime selectedDate;

  const AddEventTask({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<AddEventTask> createState() => _AddEventTaskState();
}

class _AddEventTaskState extends State<AddEventTask> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final addPersonsController = TextEditingController();

  late DateTime fromDate;
  late DateTime toDate;
  late DateTime fromTime;
  late DateTime toTime;

  late TextEditingController fromDateController = TextEditingController(),
      endDateController = TextEditingController(),
      beginTimeController = TextEditingController(),
      endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fromDate = widget.selectedDate;
    toDate = fromDate.add(const Duration(hours: 1));
    fromTime = DateTime.now();
    toTime = fromTime.add(const Duration(hours: 1));

    //initialize date and time to today's date + 1 hour
    fromDateController.text = Utils.toDate(fromDate);
    endDateController.text = Utils.toDate(toDate);
    beginTimeController.text = Utils.toTime(fromTime);
    endTimeController.text = Utils.toTime(toTime);
  }

  @override
  void dispose() {
    titleController.dispose();
    addPersonsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      height: 580,
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(
                  fieldName: "title",
                  controller: titleController,
                  title: "Nom de la tâche",
                  hint: "Nom de la tâche",
                  textColor: const Color.fromARGB(255, 185, 124, 123),
                ),
                const SizedBox(height: 20),
                buildDateTimePickers(),
                const SizedBox(height: 20),
                InputFieldIcon(
                    fieldName: "add_person",
                    iconColor: const Color.fromARGB(255, 185, 124, 123),
                    controller: addPersonsController,
                    title: "Ajouter des personnes à la tâche",
                    hint: "Invite une personne",
                    textColor: const Color.fromARGB(255, 185, 124, 123)),
                const SizedBox(height: 20),
                Center(
                  child: ButtonWhiteText(
                      backgroundColor: const Color.fromARGB(255, 185, 124, 123),
                      title: "Ajouter la tâche",
                      elevation: 0,
                      onPressed: () => {}),
                )
              ],
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
                  style: TextStyle(color: Color(0xFF73BBB3)),
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
                      endTimeController.text =
                          Utils.toTime(fromDate.add(const Duration(hours: 1)));
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
                  style: TextStyle(color: Color(0xFF73BBB3)),
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
        firstDate: firstDate ?? DateTime.now(),
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
/*
  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final event = Event(
          title: titleController.text,
          invitee: "",
          location: "Lyon",
          from: fromDate,
          to: toDate,
          isAllDay: false);

      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);

        Navigator.of(context).pop();
      } else {
        provider.addEventTask(event);
      }

      Navigator.of(context).pop();
    }
  }
  */
}
