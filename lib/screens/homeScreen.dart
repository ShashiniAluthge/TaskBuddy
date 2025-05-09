import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_buddy/screens/addTaskScreen.dart';
import 'package:task_buddy/utils/app_textStyles.dart';
import 'package:task_buddy/widgets/alertDialog.dart';
import 'package:task_buddy/widgets/taskCard.dart';
import 'package:task_buddy/widgets/topTitlebar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<String> topTitles = ['My tasks', 'Projects', 'Notes'];

  List<Map<String, String>> taskList = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskJsonList = prefs.getStringList('tasks') ?? [];

    List<Map<String, String>> loadedTasks = taskJsonList
        .map((taskJson) => Map<String, String>.from(jsonDecode(taskJson)))
        .toList();

    setState(() {
      taskList = loadedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/menu.png'),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: (Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: Colors.red,
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              )))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 23.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: 'Hello, ',
                  style: AppTextStyle.h2
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              TextSpan(
                  text: 'John !',
                  style: AppTextStyle.h1
                      .copyWith(color: Theme.of(context).colorScheme.primary))
            ])),
            Text(
              'Have a nice day !',
              style: AppTextStyle.h3
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    topTitles.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: TopTitleBar(
                            title: topTitles[index],
                            isSelected: selectedIndex == index),
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: AppTextStyle.bodyLarge
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(width: 1.0),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: GestureDetector(
                      onTap: () async {
                        final newTask = await Navigator.push(context,
                            MaterialPageRoute(builder: (e) => AddTaskScreen()));

                        if (newTask != null) {
                          setState(() {
                            taskList.add(Map<String, String>.from(newTask));
                          });
                        }

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        List<String> existingTasks =
                            prefs.getStringList('tasks') ?? [];
                        existingTasks.add(jsonEncode(newTask));
                        await prefs.setStringList('tasks', existingTasks);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: Icon(Icons.add),
                          ),
                          Text('Add',
                              style: AppTextStyle.bodySmall.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: taskList.isEmpty
                  ? const Center(child: Text('No new To-Do tasks added'))
                  : ListView.builder(
                      itemCount: taskList.length,
                      itemBuilder: (context, index) {
                        final task = taskList[index];
                        return Dismissible(
                          //this for delete by swiping
                          key: Key(task['title'] ?? index.toString()),
                          dismissThresholds: const {
                            DismissDirection.endToStart: 0.5,
                          },
                          direction: DismissDirection.endToStart,

                          confirmDismiss: (direction) async {
                            final result =
                                await showConfirmDeleteDialog(context); //implement confirm delete dialog
                            return result ?? false;

                          },
                          onDismissed: (direction) async {
                            setState(() {
                              taskList.removeAt(index);
                            });

                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setStringList('tasks',
                                taskList.map((e) => jsonEncode(e)).toList());

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Task deleted!'),
                                backgroundColor: Colors.redAccent,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },

                          background: Container(
                            color: Theme.of(context).primaryColor,
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),

                          child: TaskCard(
                            taskTitle: task['title'] ?? 'No title',
                            taskDate: task['date'] ?? 'No date',
                            taskStartTime: task['startTime'] ?? 'No start time',
                            taskEndTime: task['endTime']?? 'No end time',
                            taskDescription:
                                task['description'] ?? 'No description',
                            onDelete: () async {
                              //this for delete by using popup menu delete item
                              bool? result =
                                  await showConfirmDeleteDialog(context);
                              if (result == true) {
                                setState(() {
                                  taskList.removeAt(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Task deleted!'),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                });
                              }

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setStringList('tasks',
                                  taskList.map((e) => jsonEncode(e)).toList());
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
