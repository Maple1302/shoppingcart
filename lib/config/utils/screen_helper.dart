import 'package:flutter/material.dart';

class ScreenHelper {
  static const double phoneBreakpoint = 600;


  static bool isPhone(BuildContext context) =>
      MediaQuery.of(context).size.width < phoneBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= phoneBreakpoint;

  static double gridItemWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < phoneBreakpoint) return width / 2;
    return width / 4;
  }

  static double listItemWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width - screenPadding(context);
    if (width < phoneBreakpoint) return width / 2.5;
    return width / 4.5;
  }

  static EdgeInsets screenEdgeInsets(BuildContext context) {
    if (isPhone(context)) {
      return const EdgeInsets.all(8);
    }
    return const EdgeInsets.all(16);
  }

  static double screenPadding(BuildContext context) {
    if (isPhone(context)) {
      return 8;
    }
    return 16;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

}