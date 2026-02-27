import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFEF3E2);
const kPrimaryColor2 = Color(0xFFBEC6A0);
const kPrimaryColor3 = Color(0xFF708871);
const kPrimaryColor4 = Color(0xFF606676);

class AppTheme {
  // 1. الثيم الفاتح
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.blue, elevation: 0),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );

  // 2. الثيم الغامق
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black87, // لون خلفية غامق
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black87),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
