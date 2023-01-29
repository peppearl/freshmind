import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freshmind/components/app_bar_title.dart';
import 'package:freshmind/components/button_white_text.dart';
import 'package:freshmind/components/input_field.dart';
import 'package:freshmind/components/input_field_icon.dart';
import 'package:freshmind/events/data/models/event.dart';
import 'package:freshmind/utils.dart';
import 'package:get/get.dart';

class AddEventTask extends StatefulWidget {
  final DateTime? selectedDate;
  final Event? event;

  const AddEventTask({Key? key, this.selectedDate, this.event})
      : super(key: key);

  @override
  State<AddEventTask> createState() => _AddEventTaskState();
}

class _AddEventTaskState extends State<AddEventTask> {
  final _formKey = GlobalKey<FormBuilderState>();
  final titleController = TextEditingController();
  final addPersonsController = TextEditingController();

  late DateTime fromDate;
  late DateTime toDate;

  late TextEditingController fromDateController = TextEditingController(),
      endDateController = TextEditingController(),
      beginTimeController = TextEditingController(),
      endTimeController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    if (widget.event != null) {
      //get event details if it is an edit
      fromDate = widget.event!.fromDate;
      toDate = widget.event!.toDate;
      titleController.text = widget.event!.title;
      addPersonsController.text = widget.event!.addedUsers;
    } else {
      fromDate = widget.selectedDate!;
      toDate = fromDate.add(const Duration(hours: 1));
    }

    //initialize date and time to today's date + 1 hour
    fromDateController.text = Utils.toDate(fromDate);
    endDateController.text = Utils.toDate(toDate);
    beginTimeController.text = Utils.toTime(fromDate);
    endTimeController.text = Utils.toTime(toDate);
  }

  @override
  void dispose() {
    titleController.dispose();
    addPersonsController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SafeArea(child: AppBarTitle(title: "Ajouter une tâche")),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              height: 580,
              child: ListView(
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyInputField(
                          fieldName: "title",
                          controller: titleController,
                          title: "Nom de la tâche",
                          hint: "Nom de la tâche",
                          textColor: const Color(0xFFB97C7B),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Champ vide";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        buildDateTimePickers(),
                        const SizedBox(height: 20),
                        InputFieldIcon(
                            fieldName: "add_person",
                            iconColor: const Color(0xFFB97C7B),
                            controller: addPersonsController,
                            title: "Ajouter des personnes à la tâche",
                            hint: "Invite une personne",
                            textColor: const Color(0xFFB97C7B)),
                        const SizedBox(height: 20),
                        Center(
                          child: ButtonWhiteText(
                              backgroundColor: const Color(0xFFB97C7B),
                              title: "Ajouter la tâche",
                              elevation: 0,
                              onPressed: () => saveForm()),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Retour",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB97C7B))))
          ],
        ),
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
                  "du",
                  style: TextStyle(color: Color(0xFF73BBB3)),
                ),
                FormBuilderTextField(
                  name: "fromDate",
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
                  style: TextStyle(color: Color(0xFF73BBB3)),
                ),
                FormBuilderTextField(
                  name: "fromTime",
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
                FormBuilderTextField(
                  name: "toDate",
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
                  style: TextStyle(color: Color(0xFF73BBB3)),
                ),
                FormBuilderTextField(
                  name: "toTime",
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

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (addPersonsController.text.isEmpty) {
      addPersonsController.text = "";
    }

    //get user id of the current user
    final User? user = auth.currentUser;
    final userid = user?.uid;

    if (isValid) {
      await FirebaseFirestore.instance.collection('events').add({
        "title": titleController.text,
        "fromDate":
            (fromDate).millisecondsSinceEpoch, //transform date to timestamp
        "toDate": (toDate).millisecondsSinceEpoch, //transform date to timestamp
        "addedUsers": addPersonsController.text,
        "color": 0xFFB97C7B,
        "user_id": userid.toString(),
      });
      if (mounted) {
        Navigator.pop<bool>(context, true);
      }
    }
/*
    if (isValid) {
      final data = Map<String, dynamic>.from(_formKey.currentState!.value);

      data['title'] = titleController.text;
      data['fromDate'] = fromDate;
      data['toDate'] = toDate;
      data['addedUsers'] = addPersonsController.text;
      data['color'] = 0xFFB97C7B;
      if (widget.event == null) {
        data['user_id'] = userid.toString();

        await eventDBS.create(data);
      } else {
        //edit and update event
        await eventDBS.updateData(widget.event!.id, data);
      }

      await eventDBS.create(data);
      Get.back();
    }
    */
  }
}
