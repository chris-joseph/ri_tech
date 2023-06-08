import 'dart:ui';

const Color backgroundGrey = Color(0xFFF2F2F2);
const Color outlineGrey = Color(0xFFE5E5E5);
Color barrierGrey = const Color(0xFF000000).withOpacity(0.4);
const Color blueLight = Color(0xFF1DA1F2);
const Color blueLightest = Color(0xFFEDF8FF);
const Color blueDark = Color(0xFF0E8AD7);
const Color black = Color(0xFF323238);
const Color white = Color(0xFFFFFFFF);
const Color red = Color(0xFFF34642);
const Color textGrey = Color(0xFF323238);

class AppColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color scaffoldBackgroundPrimary;
  final Color scaffoldBackgroundSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color buttonPrimary;
  final Color buttonTextPrimary;
  final Color buttonSecondary;
  final Color buttonTextSecondary;
  final Color iconPrimary;
  final Color iconSecondary;

  AppColors({
    this.primary = blueLight,
    this.secondary = white,
    this.tertiary = red,
    this.scaffoldBackgroundPrimary = backgroundGrey,
    this.scaffoldBackgroundSecondary = white,
    this.textPrimary = black,
    this.textSecondary = textGrey,
    this.buttonPrimary = blueLight,
    this.buttonTextPrimary = white,
    this.buttonSecondary = blueLightest,
    this.buttonTextSecondary = blueLight,
    this.iconPrimary = blueLight,
    this.iconSecondary = white,
  });
}
