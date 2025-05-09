import 'package:flutter/material.dart';

import '../utils/app_textStyles.dart';

Future<bool?> showConfirmDeleteDialog(BuildContext context) {
  bool isDeleting = false;

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          Future<void> handleDelete() async {
            setState(() {
              isDeleting = true;
            });
            await Future.delayed(const Duration(seconds: 2));

            // After deletion
            Navigator.of(context).pop(true);
          }

          return AlertDialog(
            title: Center(
                child: Text(
              'Confirm Delete',
              style: AppTextStyle.buttonLarge
                  .copyWith(color: Theme.of(context).primaryColor),
            )),
            content: isDeleting
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Deleting..."),
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                    ],
                  )
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('Are you sure want to delete a task?'),
                    const SizedBox(height: 20.0),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancel')),
                        const SizedBox(width: 10.0),
                        TextButton(
                            onPressed: () {
                              handleDelete();
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                  ]),
          );
        });
      });
}
