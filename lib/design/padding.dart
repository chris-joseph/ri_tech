import 'design.dart';

class AppPadding {
  final DeviceDimension deviceDimension;
  late final double xxs;
  late final double xs;
  late final double s;
  late final double m;
  late final double l;
  late final double xl;

  AppPadding._({this.deviceDimension = DeviceDimension.medium}) {
    switch (deviceDimension) {
      case DeviceDimension.medium:
        xxs = 8;
        xs = 10;
        s = 12;
        m = 16;
        l = 20;
        xl = 24;
        break;
      case DeviceDimension.small:
        xxs = 8;
        xs = 10;
        s = 12;
        m = 16;
        l = 20;
        xl = 24;
        break;
      case DeviceDimension.big:
        xxs = 8;
        xs = 10;
        s = 12;
        m = 16;
        l = 20;
        xl = 24;
        break;
    }
  }

  static AppPadding? _instance;

  factory AppPadding.createInstance(
      {DeviceDimension deviceDimension = DeviceDimension.medium}) {
    return _instance ??= AppPadding._(deviceDimension: deviceDimension);
  }

  static AppPadding get padding {
    if (_instance == null) {
      AppPadding.createInstance();
    }

    return _instance!;
  }
}
