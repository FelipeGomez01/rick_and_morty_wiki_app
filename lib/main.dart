import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rick_and_morty_wiki_app/providers/home_provider.dart';
import 'package:rick_and_morty_wiki_app/router/routes.dart';
import 'package:rick_and_morty_wiki_app/theme/theme_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ( _ ) => HomeProvider(),
          lazy: true
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty Wiki',
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: ThemeApp.theme(context)
    );
  }
}
