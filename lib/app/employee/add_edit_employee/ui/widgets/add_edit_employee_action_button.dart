import 'package:flutter/material.dart';
import 'package:ri_tech/design/design.dart';

class AppButtonSmall extends StatelessWidget {
  late final TextStyle buttonTextStyle;
  late final Color buttonColor;
  final String buttonText;
  final VoidCallback onPressed;
  AppButtonSmall.primary({
    super.key,
    TextStyle? buttonTextStyle,
    Color? buttonColor,
    required this.onPressed,
    required this.buttonText,
  }) {
    this.buttonColor = buttonColor ?? AppColors.colors.buttonPrimary;
    this.buttonTextStyle = buttonTextStyle ??
        AppFonts.fonts.b1.copyWith(
          color: AppColors.colors.buttonTextPrimary,
          fontWeight: FontWeight.w500,
          height: 1,
        );
  }
  AppButtonSmall.secondary({
    super.key,
    TextStyle? buttonTextStyle,
    Color? buttonColor,
    required this.onPressed,
    required this.buttonText,
  }) {
    this.buttonColor = buttonColor ?? AppColors.colors.buttonSecondary;
    this.buttonTextStyle = buttonTextStyle ??
        AppFonts.fonts.b1.copyWith(
          color: AppColors.colors.buttonTextSecondary,
          fontWeight: FontWeight.w500,
          height: 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 74,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: SizedBox(
            height: 16, child: Text(buttonText, style: buttonTextStyle)),
      ),
    );
  }
}
