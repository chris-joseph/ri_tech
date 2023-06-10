import 'dart:ui';

const Color backgroundGrey = Color(0xFFF2F2F2);
const Color outlineGrey = Color(0xFFE5E5E5);
Color barrierGrey = const Color(0xFF000000).withOpacity(0.4);
const Color disabledGrey = Color(0xFF949C9E);
const Color blueLight = Color(0xFF1DA1F2);
const Color blueLightest = Color(0xFFEDF8FF);
const Color blueDark = Color(0xFF0E8AD7);
const Color black = Color(0xFF323238);
const Color white = Color(0xFFFFFFFF);
const Color red = Color(0xFFF34642);
const Color textGrey = Color(0xFF949C9E);

enum AppBrightness { light, dark }

class AppColors {
  late final Color primary;
  late final Color secondary;
  late final Color tertiary;
  late final Color scaffoldBackgroundPrimary;
  late final Color scaffoldBackgroundSecondary;
  late final Color textPrimary;
  late final Color textSecondary;
  late final Color buttonPrimary;
  late final Color buttonTextPrimary;
  late final Color buttonSecondary;
  late final Color buttonTextSecondary;
  late final Color iconPrimary;
  late final Color iconSecondary;
  late final Color appBarBackground;

  AppColors._light({AppBrightness deviceBrightness = AppBrightness.light}) {
    switch (deviceBrightness) {
      case AppBrightness.light:
      case AppBrightness.dark:
        primary = blueLight;
        secondary = white;
        tertiary = red;
        scaffoldBackgroundPrimary = backgroundGrey;
        scaffoldBackgroundSecondary = white;
        textPrimary = black;
        textSecondary = textGrey;
        buttonPrimary = blueLight;
        buttonTextPrimary = white;
        buttonSecondary = blueLightest;
        buttonTextSecondary = blueLight;
        iconPrimary = blueLight;
        iconSecondary = white;
        appBarBackground = blueLight;
    }
  }

  static AppColors? _instance;

  factory AppColors.createInstance(
      {AppBrightness deviceBrightness = AppBrightness.light}) {
    return _instance ??= AppColors._light();
  }
  static AppColors get colors {
    if (_instance == null) {
      AppColors.createInstance();
    }

    return _instance!;
  }
}
