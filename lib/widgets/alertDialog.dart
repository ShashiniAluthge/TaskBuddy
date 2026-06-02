import 'package:flutter/material.dart';
import '../utils/app_textStyles.dart';

Future<bool?> showConfirmDialog(
  BuildContext context, {
  String alertTitle = 'Confirm Delete',
  String performTitle = 'Deleting...',
  String question = 'Are you sure want to delete a task?',
  String answerText1 = 'Cancel',
  String answerText2 = 'Delete',
}) {
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
              alertTitle,
              style: AppTextStyle.buttonLarge
                  .copyWith(color: Theme.of(context).primaryColor),
            )),
            content: isDeleting
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(performTitle),
                      SizedBox(height: 20),
                      CircularProgressIndicator(),
                    ],
                  )
                : Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(question),
                    const SizedBox(height: 20.0),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(answerText1)),
                        const SizedBox(width: 10.0),
                        TextButton(
                            onPressed: () {
                              handleDelete();
                            },
                            child: Text(
                              answerText2,
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                  ]),
          );
        });
      });
}
