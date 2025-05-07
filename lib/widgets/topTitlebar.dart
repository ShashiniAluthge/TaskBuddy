import 'package:flutter/material.dart';
import '../utils/app_textStyles.dart';

class TopTitleBar extends StatelessWidget {
  final String title;
  final bool isSelected;

  const TopTitleBar({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedCardColor = const Color(0xFF002596);
    Color unselectedCardColor = const Color(0xFFCBD8FF);

    final Color backgroundColor =
        isSelected ? selectedCardColor : unselectedCardColor;
    final Color textColor = isSelected ? Colors.white : Colors.black;

    return Container(
      height: 45.0,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(30.0)),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(title,
            style: AppTextStyle.buttonMedium.copyWith(color: textColor)),
      ),
    );
  }
}
