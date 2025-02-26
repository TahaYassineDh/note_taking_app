import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.grey[900],
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ));
}
