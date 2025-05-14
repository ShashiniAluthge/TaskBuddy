import 'package:flutter/material.dart';
import '../utils/app_textStyles.dart';

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final String taskDate;
  final String taskStartTime;
  final String taskEndTime;
  final String taskDescription;
  final String taskStatus;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TaskCard({
    super.key,
    required this.taskTitle,
    required this.taskDate,
    required this.taskStartTime,
    required this.taskEndTime,
    required this.taskDescription,
    this.taskStatus = 'To Do',
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          taskTitle,
                          style: AppTextStyle.bodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert_outlined),
                          color: Colors.white,
                          onSelected: (value) {
                            if (value == 'Edit') {
                              onEdit();
                            } else if (value == 'Delete') {
                              onDelete();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: 'Edit',
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: AppTextStyle.bodySmall.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                            PopupMenuItem(
                                value: 'Delete',
                                child: Center(
                                  child: Text('Delete',
                                      style: AppTextStyle.bodySmall
                                          .copyWith(color: Colors.redAccent)),
                                ))
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(taskDate,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.access_time_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(taskStartTime,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        const SizedBox(width: 10.0),
                        Text('-  $taskEndTime',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  taskDescription,
                  style: AppTextStyle.bodySmall
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: IntrinsicWidth(
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0)),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 16.0),
                        child: Text(taskStatus,
                            style: AppTextStyle.buttonSmall
                                .copyWith(color: Colors.cyan)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15.0)
      ],
    );
  }
}
