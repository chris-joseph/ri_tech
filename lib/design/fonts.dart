import 'dart:ui';

const fontFamily = "Roboto";

enum TStyle { h1, h2, b1, b2 }

enum DeviceDimension { small, medium, big }

class AppFonts {
  late final Map<TStyle, TextStyle> textStyle;
  final DeviceDimension deviceDimension;
  AppFonts({this.deviceDimension = DeviceDimension.medium}) {
    textStyle = medium;
  }

  Map<TStyle, TextStyle> medium = {
    TStyle.h1: TextStyle(
      fontFamily: fontFamily,
      fontSize: 18,
    ),
    TStyle.h2: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
    ),
    TStyle.b1: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
    ),
    TStyle.b2: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
    ),
  };
}
