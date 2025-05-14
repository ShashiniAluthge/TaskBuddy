import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_buddy/utils/app_textStyles.dart';
import 'package:task_buddy/widgets/alertDialog.dart';
import 'package:task_buddy/widgets/inputfield.dart';

class AddTaskScreen extends StatefulWidget {
  //this for receive task data for editing
  final Map<String, String>? task;
  final bool isEditing;
  final int? taskIndex;

  AddTaskScreen(
      {super.key, this.task, required this.isEditing, this.taskIndex});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var descriptionController = TextEditingController();
  bool isEditing = false;

  int originalIndex = -1; //store original task index for if editing

  @override
  void initState() {
    super.initState();

    //check if edit existing task
    if (widget.task != null) {
      isEditing = true;

      titleController.text = widget.task!['title'] ?? '';
      dateController.text = widget.task!['date'] ?? '';
      startTimeController.text = widget.task!['startTime'] ?? '';
      endTimeController.text = widget.task!['endTime'] ?? '';
      descriptionController.text = widget.task!['description'] ?? '';
    }
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

  Future<void> saveTask(taskData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> taskList = prefs.getStringList('tasks') ?? [];

    taskList.add(jsonEncode(taskData));
    await prefs.setStringList('tasks', taskList);
  }

  void showSnackBarMessage(taskData, bool isEdit) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isEdit ? 'Task updated!' : 'Task created!'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context, taskData);
  }

  Future<void> updateExistingTask(taskData, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList = prefs.getStringList('tasks') ?? [];

    if (index >= 0 && index < taskList.length) {
      taskList[index] = jsonEncode(taskData);
      await prefs.setStringList('tasks', taskList);
    } else {
      taskList.add(jsonEncode(taskData));
      await prefs.setStringList('tasks', taskList);
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
          isEditing ? 'Edit Task' : 'Create New task',
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
                    var title = titleController.text.trim();
                    var date = dateController.text.trim();
                    var startTime = startTimeController.text.trim();
                    var endTime = endTimeController.text.trim();
                    var description = descriptionController.text.trim();

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

                    Map<String, String> taskData = {
                      'title': title,
                      'date': date,
                      'startTime': startTime,
                      'endTime': endTime,
                      'description': description,
                    };

                    if (isEditing) {
                      bool? confirmed = await showConfirmDialog(context,
                          alertTitle: 'Confirm Edit',
                          performTitle: 'Updating...',
                          question: 'Are you sure want to edit this task?',
                          answerText1: 'cancel',
                          answerText2: 'Save');

                      if (confirmed != true) {
                        return; // for cancel
                      }
                      if (widget.taskIndex != null) {
                        await updateExistingTask(taskData, widget.taskIndex!);
                      } else {
                        await saveTask(taskData);
                      }

                      showSnackBarMessage(taskData, isEditing = true);
                    } else {
                      await saveTask(taskData);
                      showSnackBarMessage(taskData, isEditing = false);
                    }
                  },
                  child: Text(
                    isEditing ? 'Save' : 'Create Task',
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
}
