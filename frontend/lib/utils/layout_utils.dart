import 'package:flutter/material.dart';

class ScreenSize {
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Get a height value adjusted by a percentage of the screen height
  static double adjustedHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  // Get a width value adjusted by a percentage of the screen width
  static double adjustedWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }
}

// Pixel constants adjusted to screen size
class AppPadding {
  // 5% of screen height
  static double p5(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 0.5);

  // 1% of screen height
  static double p10(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 1);

  // 2% of screen height
  static double p20(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 2);

  // 3% of screen height
  static double p30(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 3);

  // 4% of screen height
  static double p40(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 4);

  // 5% of screen height
  static double p50(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 5);

  // 6% of screen height
  static double p60(BuildContext context) =>
      ScreenSize.adjustedHeight(context, 6);
}