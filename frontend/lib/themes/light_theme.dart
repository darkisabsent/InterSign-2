import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    // Determines if the theme is light or dark
    primaryColor: Colors.blue,
    // Primary color for major parts of the app (toolbars, tab bars, etc.)
    primaryColorDark: Colors.blue[700],
    // Darker variant of the primary color
    primaryColorLight: Colors.blue[100],
    // Lighter variant of the primary color
    canvasColor: Colors.grey[50],
    // Background color for larger parts of the app
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

// Typography
    textTheme: TextTheme(
      headlineLarge: TextStyle(color: Colors.blue[900]),
      headlineMedium: const TextStyle(color: Colors.black),
      bodyLarge: TextStyle(color: Colors.blue[900]),
      bodyMedium: const TextStyle(color: Colors.black),
// ... and so on for other text styles
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
