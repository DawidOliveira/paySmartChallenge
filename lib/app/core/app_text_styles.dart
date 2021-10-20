import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static final textThemeLight = TextTheme(
    bodyText1: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.grey[400],
      fontWeight: FontWeight.bold,
    ),
    subtitle1: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headline6: const TextStyle(
      color: Colors.black,
    ),
  );

  static final textThemeDark = TextTheme(
    bodyText1: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      color: Colors.grey[400],
      fontWeight: FontWeight.bold,
    ),
    subtitle1: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    headline6: const TextStyle(),
  );
}
