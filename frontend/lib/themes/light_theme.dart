import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    // Determines if the theme is light or dark
    /*primaryColor: Colors.blue,
    // Primary color for major parts of the app (toolbars, tab bars, etc.)
    primaryColorDark: Colors.blue[700],
    // Darker variant of the primary color
    primaryColorLight: Colors.blue[100],
    // Lighter variant of the primary color
    canvasColor: Colors.grey[50],
    // Background color for larger parts of the app*/

    scaffoldBackgroundColor: Colors.white,
    // Background color for Scaffolds
    cardColor: Colors.white,
    // Background color of cards
    dividerColor: Colors.grey,
    // Color of dividers
    highlightColor: Colors.amber[700],
    // Color of ink splash when tapped
    splashColor: Colors.amber[200],
    // Color of ink splash during a ripple effect
    unselectedWidgetColor: Colors.grey[400],
    // Color for widgets like unchecked checkboxes, radio buttons, etc.
    disabledColor: Colors.grey[200],
    // Color to indicate disabled widgets
    secondaryHeaderColor: Colors.blue[50],
    // Background color for sticky headers

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        minimumSize: WidgetStateProperty.all(const Size(400, 60)),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0)),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    ),

// Typography
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        color: Color(0xff000557),
        fontSize: 50,
        fontWeight: FontWeight.w900,
      ),
      headlineMedium: const TextStyle(
        color: Colors.black,
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.blue[900]),
      bodyMedium: const TextStyle(color: Colors.black),
    ),

// Input Decoration themes
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.blue[100],
    ),

// Icon themes
    iconTheme: IconThemeData(
      color: Colors.blue[600],
    ),
  );
}
