import 'package:flutter/material.dart';
import 'package:task_buddy/utils/app_textStyles.dart';
import 'package:task_buddy/widgets/inputfield.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

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
            const InputField(title: 'Title'),
            const InputField(title: 'Date'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: InputField(title: 'Start Time')),
                SizedBox(width: 20.0),
                Expanded(child: InputField(title: 'End Time')),
              ],
            ),
            const SizedBox(height: 20.0),
            const InputField(
              title: 'Description',
              isTextArea: true,
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0)),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Create Task',
                    style:
                        AppTextStyle.buttonLarge.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
