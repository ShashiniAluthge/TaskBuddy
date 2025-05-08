import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_buddy/screens/addTaskScreen.dart';
import 'package:task_buddy/utils/app_textStyles.dart';
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
                  'Today Tasks',
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (e) => const AddTaskScreen()));
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
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TaskCard(
                      taskTitle: 'Team Meeting',
                      taskTime: '8:00 AM',
                      taskDescription:
                          'Discuss all ideas and questions about new projects.',
                      taskStatus: 'Ongoing',
                    ),
                    TaskCard(
                      taskTitle: 'Check mail',
                      taskTime: '10:00 AM',
                      taskDescription:
                          'Check all mails regarding the projects.',
                      taskStatus: 'To Do',
                    ),
                    TaskCard(
                      taskTitle: 'Dashboard Design',
                      taskTime: '10:30 AM',
                      taskDescription: 'Design UI for the Dashboard',
                      taskStatus: 'To Do',
                    ),
                    TaskCard(
                      taskTitle: 'Update Report',
                      taskTime: '3:00 PM',
                      taskDescription: 'Update all updates of the project',
                      taskStatus: 'To Do',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
