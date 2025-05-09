import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_buddy/utils/app_textStyles.dart';
import 'package:task_buddy/widgets/inputfield.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // for date picker
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        dateController.text = pickedDate.toString().split(" ")[0];
      });
    }
  }

  //for the time picker

  String formatTimeOfDay(TimeOfDay time, BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return localizations.formatTimeOfDay(time, alwaysUse24HourFormat: false);
  }

  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (pickedTime != null) {
      setState(() {
        controller.text = formatTimeOfDay(pickedTime, context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          'Create New task',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            InputField(
              title: 'Title',
              controller: titleController,
              //hintText: 'Add a title',
            ),
            InputField(
              title: 'Date',
              hintText: 'Select date',
              controller: dateController,
              inputIcon: IconButton(
                onPressed: () {
                  selectDate(context);
                },
                icon: Icon(
                  Icons.calendar_month_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: InputField(
                  title: 'Start Time',
                  controller: startTimeController,
                  hintText: 'Select start time',
                  inputIcon: IconButton(
                      onPressed: () {
                        selectTime(context, startTimeController);
                      },
                      icon: Icon(Icons.access_time_rounded,
                          color: Theme.of(context).primaryColor)),
                )),
                const SizedBox(width: 20.0),
                Expanded(
                    child: InputField(
                  title: 'End Time',
                  controller: endTimeController,
                  hintText: 'Select end time',
                  inputIcon: IconButton(
                      onPressed: () {
                        selectTime(context, endTimeController);
                      },
                      icon: Icon(Icons.access_time_rounded,
                          color: Theme.of(context).primaryColor)),
                )),
              ],
            ),
            const SizedBox(height: 20.0),
            InputField(
              title: 'Description',
              controller: descriptionController,
              //hintText: 'Add a short description',
              isTextArea: true,

            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: AppTextStyle.buttonLarge,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () async {
                    var title = titleController.text.toString();
                    var date = dateController.text.toString();
                    var startTime = startTimeController.text.toString();
                    var endTime = endTimeController.text.toString();
                    var description = descriptionController.text.toString();

                    if (title.isEmpty && description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields!'),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    List<String> taskList = prefs.getStringList('tasks') ?? [];

                    Map<String, String> newTask = {
                      'title': title,
                      'date': date,
                      'startTime': startTime,
                      'endTime': endTime,
                      'description': description,
                    };

                    taskList.add(jsonEncode(newTask));
                    await prefs.setStringList('tasks', taskList);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Task created!'),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context, newTask);
                  },
                  child: Text(
                    'Create Task',
                    style:
                        AppTextStyle.buttonLarge.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
}
