import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rick_and_morty_wiki_app/providers/home_provider.dart';
import 'package:rick_and_morty_wiki_app/theme/theme_app.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_appbar.dart';
import 'package:rick_and_morty_wiki_app/widgets/custom_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context,listen: true);

    homeProvider.init();

    print('init');

    return Scaffold(
      appBar: const CustomAppBar(),
      body: homeProvider.isLoading
        ? const CustomLoader()
        : Column(
        children: [
          SeriesInNumbers(
            numEpisodes: homeProvider.numEpisodes,
            mostPopulatedLocation: homeProvider.mostPopulatedLocation
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6,right: 12),
              child: CharacterList(
                scrollController: homeProvider.scrollController,
                characters: homeProvider.characters.results
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
            size: 18
          )
        ]
      )
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.size = 14
  }) : super(key: key);

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w900,
          fontSize: size
        )
      )
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.scrollController,
    required this.characters
  }) : super(key: key);

  final ScrollController scrollController;
  final dynamic characters;

  @override
  Widget build(BuildContext context) {
    print('characterlist');
    return ListView.builder(
      controller: scrollController,
      itemCount: characters.length,
      itemBuilder: (_, index){
          return CharacterItem(
            image: characters[index].image,
            name: characters[index].name,
            status: characters[index].status,
            species: characters[index].species,
          );
        }
    );
  }
}

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.image,
    required this.name,
    required this.status,
    required this.species
  }) : super(key: key);

  final String image;
  final String name;
  final String status;
  final String species;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => print('clic'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  image: NetworkImage(
                    image
                  ),
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  height: 123,
                  width: 123
                )
              )
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
                    onTap: () => print('clic'),
                    child: CustomText(text: name, size: 17)
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
                      CustomText(text: status)
                    ]
                  ),
                  CustomText(text: species),
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

