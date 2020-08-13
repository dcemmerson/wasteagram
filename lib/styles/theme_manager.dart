import 'package:flutter/material.dart';

class ThemeManager {
  // //use static constants to easily allow for additional theme colors
  // static const DarkMode = 'dark_mode';
  // static const LightMode = 'light';

  final bool darkMode;

  ThemeData _themeLight = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.cyan[600],

      // Define the default font family.
      fontFamily: 'Ubuntu',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ));

  ThemeData _themeDark = ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.orange,
      accentColor: Colors.orange[800],

      // Define the default font family.
      fontFamily: 'Ubuntu',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ));

  // light mode

  // dark mode

  ThemeManager({this.darkMode: false});

  ThemeData get themeData => darkMode ? _themeDark : _themeLight;
}
