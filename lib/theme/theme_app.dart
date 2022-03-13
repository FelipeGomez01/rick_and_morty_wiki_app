import 'package:flutter/material.dart';

class ThemeApp
{
  static const Color primaryColor = Color(0xFF191E38);
  static const Color secondaryColor = Color(0xFFF1F2F3);

  static theme(BuildContext context){
    return ThemeData(
      primaryColor: primaryColor,
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: primaryColor,
        displayColor: primaryColor
      )
    );
  }
}