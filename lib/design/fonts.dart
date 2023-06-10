import 'package:flutter/material.dart';

import 'design.dart';

const fontFamily = "Roboto";

enum TStyle { h1, h2, b1, b2 }

class AppFonts {
  late final Map<TStyle, TextStyle> textStyle;
  final DeviceDimension deviceDimension;
  AppFonts({this.deviceDimension = DeviceDimension.medium}) {
    textStyle = medium;
  }

  TextStyle? getTextStyle(TStyle style) {
    return textStyle[TStyle] ?? const TextStyle();
  }

  Map<TStyle, TextStyle> medium = {
    TStyle.h1: const TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
    ),
    TStyle.h2: const TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
    ),
    TStyle.b1: const TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
    ),
    TStyle.b2: const TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
    ),
  };
}

AppFonts appFonts = AppFonts();
