import 'package:flutter/material.dart';
import 'package:ri_tech/design/design.dart';

class DatePickerQuickOptionsWidget extends StatelessWidget {
  final String title;

  final bool isSelected;
  final Function onTap;
  const DatePickerQuickOptionsWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colors.buttonPrimary
              : AppColors.colors.buttonSecondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            color: isSelected
                ? AppColors.colors.buttonTextPrimary
                : AppColors.colors.buttonTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
