import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyThemes {
  static Color primaryColor = Color.fromARGB(255, 49, 12, 217);
  static const Color buttonColor = Color.fromARGB(255, 49, 12, 217);
  static const Color iconColor = Color.fromARGB(255, 49, 12, 217);
  static const Color textColor = Colors.grey;
  static Color hintColor = Colors.grey.shade300;
  static Color shimmerCollor = Colors.grey.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black54,
    colorScheme: const ColorScheme.dark(),
    cardColor: Colors.white,
    primaryColor: Colors.black,
    canvasColor: Colors.grey.shade600,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    cardColor: Colors.black,
    canvasColor: Colors.grey.shade200,
    primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}
