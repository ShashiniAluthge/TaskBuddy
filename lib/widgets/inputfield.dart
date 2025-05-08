import 'package:flutter/material.dart';

import '../utils/app_textStyles.dart';

class InputField extends StatelessWidget {
  final String title;
  final bool isTextArea;
  final TextEditingController? controller;

  const InputField({super.key, required this.title, this.isTextArea = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          maxLines: isTextArea ? 5 : 1,
          decoration: InputDecoration(
              label: Text(title),
              labelStyle: AppTextStyle.bodyMedium
                  .copyWith(color: Theme.of(context).primaryColor),
              enabledBorder: isTextArea
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(16.0))
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary)),
              focusedBorder: isTextArea
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                      borderRadius: BorderRadius.circular(16.0))
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary)),
              floatingLabelBehavior: isTextArea
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto),
        ),
        const SizedBox(height: 20.0)
      ],
    );
  }
}
