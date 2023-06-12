import 'package:flutter/material.dart';

enum AppTheme { lightTheme, darkTheme }

class AppThemes {
  static final AppThemeData = {
    AppTheme.darkTheme: ThemeData(
      primaryColor: Colors.black,
      brightness: Brightness.dark,
      dividerColor: Colors.black,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black),
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      //     .copyWith(background: const Color(0xFF212121)),
    ),
    //
    //
    AppTheme.lightTheme: ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      dividerColor: const Color(0xFF757575),
      appBarTheme: AppBarTheme(color: Color(0xFF7B2CBF)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0XFF7b2cbf), foregroundColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.black),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: const Color(0xFFE5E5E5)),
    ),
  };
}
