import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:paysmart_movies/app/core/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'paySmart Movies',
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      debugShowCheckedModeBanner: false,
    ).modular();
  }
}
