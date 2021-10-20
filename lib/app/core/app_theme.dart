import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paysmart_movies/app/core/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static final themeLight = ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: AppTextStyles.textThemeLight,
  );
  static final themeDark = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF333333),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: AppTextStyles.textThemeDark,
  );
}
