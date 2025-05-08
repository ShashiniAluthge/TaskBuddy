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
            ),
            InputField(
              title: 'Date',
              controller: dateController,
            ),
            InputField(
              title: 'Start Time',
              controller: startTimeController,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //         child: InputField(
            //       title: 'Start Time',
            //       controller: startTimeController,
            //     )),
            //     const SizedBox(width: 20.0),
            //     Expanded(
            //         child: InputField(
            //       title: 'End Time',
            //       controller: endTimeController,
            //     )),
            //   ],
            // ),
            const SizedBox(height: 20.0),
            InputField(
              title: 'Description',
              controller: descriptionController,
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
                      'startTime': startTime,
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
                    Navigator.pop(context,newTask);
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
