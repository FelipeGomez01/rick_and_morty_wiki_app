import 'package:flutter/material.dart';

import 'package:rick_and_morty_wiki_app/theme/theme_app.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_appbar.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_image.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_text.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamic character = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(45,65,45,0),
          child: Container(
            color: ThemeApp.secondaryColor,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const CustomText(text: 'Detalle', size: 20,paddingVertical: 12),
                CustomImage(urlImage: character.image, size: 200),
                const SizedBox(height: 22),
                CustomText(
                  text: character.name,
                  size: 20,
                  ellipsis: false,
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(left: 17),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: '- ${character.gender}', paddingVertical: 2),
                        CustomText(
                            text: '- ${character.origin.name}',
                            paddingVertical: 2,
                            ellipsis: false
                        ),
                        CustomText(
                            text: '- ${character.location.name}',
                            paddingVertical: 2,
                            ellipsis: false
                        ),
                        CustomText(
                            text: '- Number of episodes ${character.episode.length}',
                            paddingVertical: 2
                        ),
                        const SizedBox(height: 110)
                      ]
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}