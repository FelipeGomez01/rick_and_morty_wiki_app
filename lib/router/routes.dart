import 'package:flutter/material.dart';

import 'package:rick_and_morty_wiki_app/screens/home_screen.dart';
import 'package:rick_and_morty_wiki_app/screens/character_detail_screen.dart';

class AppRoutes
{
  static const String initialRoute = '/';

  static Map<String,WidgetBuilder> routes =
  {
    '/' : ( _ ) => const HomeScreen(),
    'detail' : ( _ ) => const CharacterDetailScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    print('por aqui paso');
    return MaterialPageRoute(
        builder: (context) => const HomeScreen()
    );
  }
}