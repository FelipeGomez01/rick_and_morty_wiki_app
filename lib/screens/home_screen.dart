import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rick_and_morty_wiki_app/providers/home_provider.dart';
import 'package:rick_and_morty_wiki_app/theme/theme_app.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_appbar.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_image.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_loader.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_text.dart';
import 'package:rick_and_morty_wiki_app/widgets/show_error.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    homeProvider.init();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: homeProvider.isLoading
        ? const CustomLoader()
        : homeProvider.failedRequest
          ? ShowError(
              message: 'Parece que Evil Morty ha interrumpido la petición',
              onPressed: () => homeProvider.getData()
          )
          : Column(
            children: [
              SeriesInNumbers(
                numEpisodes: homeProvider.numEpisodes,
                mostPopulatedLocation: homeProvider.mostPopulatedLocation
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6,right: 14),
                  child: CharacterList(
                    scrollController: homeProvider.scrollController,
                    characters: homeProvider.listCharacters,
                    paginate: homeProvider.paginate
                  )
                )
              )
            ]
          )
    );
  }
}

class SeriesInNumbers extends StatelessWidget {
  const SeriesInNumbers({
    Key? key,
    required this.numEpisodes,
    required this.mostPopulatedLocation
  }) : super(key: key);

  final int numEpisodes;
  final String mostPopulatedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
      color: ThemeApp.secondaryColor,
      child: Column(
        children: [
          const CustomText(text: 'La serie en números', size: 20),
          CustomText(text: '$numEpisodes Número de epiodios', size: 18),
          CustomText(
            text: 'Location con más personajes: $mostPopulatedLocation',
            size: 18,
            ellipsis: false,
          )
        ]
      )
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.scrollController,
    required this.characters,
    required this.paginate
  }) : super(key: key);

  final ScrollController scrollController;
  final dynamic characters;
  final bool paginate;

  @override
  Widget build(BuildContext context) {
    int endIndex;

    return ListView.builder(
      controller: scrollController,
      itemCount: characters.length,
      itemBuilder: (_, index){
        endIndex = index + 1;
        if(endIndex == characters.length && paginate){
          return Center(
              child: Image.asset('assets/images/portal_loading.gif', width: 80, height: 80)
          );
        }
        return CharacterItem(
          character: characters[index]
        );
      }
    );
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.character
  }) : super(key: key);

  final dynamic character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, 'detail', arguments: character),
              child: CustomImage(urlImage: character.image, size: 123)
            )
          ),
          Expanded(
            child: Container(
              height: 123,
              color: ThemeApp.secondaryColor,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, 'detail', arguments: character),
                    child: CustomText(text: character.name, size: 17)
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.circle_rounded,
                          color: Color(0xFF737373),
                          size: 15,
                        )
                      ),
                      CustomText(text: character.status)
                    ]
                  ),
                  CustomText(text: character.species),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color(0xFFDDFB2F),
                      child: const CustomText(text: 'Detalle')
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}

