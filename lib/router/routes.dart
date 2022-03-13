import 'package:flutter/material.dart';

import 'package:rick_and_morty_wiki_app/screens/home_screen.dart';

class AppRoutes
{
  static const String initialRoute = '/';

  static Map<String,WidgetBuilder> routes =
  {
    '/' : ( _ ) => const HomeScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
        builder: (context) => const HomeScreen()
    );
  }
}