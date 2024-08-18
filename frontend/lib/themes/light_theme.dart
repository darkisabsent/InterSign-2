import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    highlightColor: const Color(0xffa093f5),

    // Determines if the theme is light or dark
    /*primaryColor: Colors.blue,
    // Primary color for major parts of the app (toolbars, tab bars, etc.)
    primaryColorDark: Colors.blue[700],
    // Darker variant of the primary color
    primaryColorLight: Colors.blue[100],
    // Lighter variant of the primary color
    canvasColor: Colors.grey[50],
    // Background color for larger parts of the app
    splashColor: Colors.amber[200],
    // Color of ink splash during a ripple effect
    */

    dividerColor: Colors.grey,
    // Color of dividers

    unselectedWidgetColor: Colors.grey[400],
    // Color for widgets like unchecked checkboxes, radio buttons, etc.
    disabledColor: Colors.grey[200],
    // Color to indicate disabled widgets
    secondaryHeaderColor: Colors.blue[50],
    // Background color for sticky headers

    appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 1),

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

    /// Typography
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        color: Color(0xff000557),
        fontSize: 50,
        fontWeight: FontWeight.w900,
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: const TextStyle(
        color: Colors.black,
        fontSize: 27,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: const TextStyle(
        color: Color(0xff000557),
        fontSize: 30,
        fontWeight: FontWeight.w900,
        overflow: TextOverflow.ellipsis,
      ),
      bodyLarge: TextStyle(
        color: Colors.blue[900],
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
    ),

    /// Input Decoration themes
    inputDecorationTheme: InputDecorationTheme(
      focusColor: Colors.blue[100],
    ),

    /// Icon themes
    iconTheme: IconThemeData(
      color: Colors.blue[600],
    ),
  );
}
