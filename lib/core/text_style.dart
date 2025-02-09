import 'package:flutter/material.dart';

import 'color.dart';

class AppTextStyle {
  static TextStyle buttonTextStyle = TextStyle(color: Colors.white);
  static TextStyle productNameTextStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle productPriceTextStyle = const TextStyle(
    fontSize: 16,
    color: ColorManager.orange,
    fontWeight: FontWeight.w600,
  );
}
