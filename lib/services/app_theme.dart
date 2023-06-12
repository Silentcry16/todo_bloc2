// ignore_for_file: non_constant_identifier_names

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

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.grey, // Set the text color
          elevation: 5, // Set the button elevation
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the button border radius
          ),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white // Set the text size
              ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                10), // Set the border radius of the text field
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors
                    .grey), // Set the color of the border when the text field is enabled
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors
                    .grey), // Set the color of the border when the text field is focused
          ),
          hintStyle: const TextStyle(
            color: Colors.white, // Set the color of the hint text
          ),
          prefixIconColor: Colors.grey,
          labelStyle: const TextStyle(color: Colors.white)),
    ),
    //
    //
    //
    //
    //
    //
    //
    //

    AppTheme.lightTheme: ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      dividerColor: const Color(0xFF757575),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF7B2CBF),
        foregroundColor: Colors.white,
      ),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color(0xFF7B2CBF), // Set the text color
          elevation: 5, // Set the button elevation
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the button border radius
          ),
          textStyle: const TextStyle(
            fontSize: 16, // Set the text size
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              10), // Set the border radius of the text field
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Color(
                  0xFF7B2CBF)), // Set the color of the border when the text field is enabled
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Color(
                  0xFF7B2CBF)), // Set the color of the border when the text field is focused
        ),
        hintStyle: const TextStyle(
          color: Colors.grey, // Set the color of the hint text
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: const Color(0xFFE5E5E5)),
      // Customizing the colors for ExpansionPanelList
    ),
  };
}
