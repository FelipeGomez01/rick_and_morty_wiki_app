import 'package:flutter/material.dart';

class ThemeApp
{
  static const Color primaryColor = Color(0xFF191E38);

  /*static final theme = ThemeData.light().copyWith(
      primaryColor: _primary,
      appBarTheme: const AppBarTheme(
        color: _primary,
      )
  );*/
  static theme(BuildContext context){
    return ThemeData(
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: primaryColor,
          displayColor: primaryColor,
        )
    );
  }
}