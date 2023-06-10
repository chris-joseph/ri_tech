import 'package:flutter/material.dart';

import 'design.dart';

const fontFamily = "Roboto";

enum TStyle { h1, h2, b1, b2 }

class AppFonts {
  late final TextStyle h1;
  late final TextStyle h2;
  late final TextStyle b1;
  late final TextStyle b2;

  AppFonts._medium({deviceDimension = DeviceDimension.medium}) {
    switch (deviceDimension) {
      case DeviceDimension.medium:
        h1 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
        );
        h2 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
        );
        b1 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
        );
        b2 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
        );
        break;
      case DeviceDimension.small:
        h1 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
        );
        h2 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
        );
        b1 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
        );
        b2 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
        );
        break;
      case DeviceDimension.big:
        h1 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
        );
        h2 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
        );
        b1 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
        );
        b2 = const TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
        );
        break;
    }
  }

  static AppFonts? _instance;

  factory AppFonts.createInstance({deviceDimension = DeviceDimension.medium}) {
    return _instance ??= AppFonts._medium(deviceDimension: deviceDimension);
  }
  static AppFonts get fonts {
    if (_instance == null) {
      AppFonts.createInstance();
    }

    return _instance!;
  }
}
