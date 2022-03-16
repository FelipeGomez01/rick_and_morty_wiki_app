import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:rick_and_morty_wiki_app/config/constants.dart';
import 'package:rick_and_morty_wiki_app/models/character_model.dart';
import 'package:rick_and_morty_wiki_app/models/info_characters_model.dart';

class HomeProvider extends ChangeNotifier
{
  HomeProvider(){
    getData();
  }

  ScrollController scrollController = ScrollController();

  late InfoCharactersModel infoCharacters;

  late List<CharacterModel> listCharacters = [];

  bool isLoading = true;

  int _page = 0;

  int numEpisodes = 0;

  String mostPopulatedLocation = '';

  bool _pendingRequest = false;

  bool paginate = true;

  bool failedRequest = false;

  void init(){
    scrollController.addListener(() {
      final pixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;
      if(pixels == maxScrollExtent && paginate && !_pendingRequest)
      {
        getCharacters();
        _pendingRequest = true;
      }
    });
  }

  Future<void> getData() async {
    isLoading = true;

    var data = await sendRequest('api/episode');
    numEpisodes = data['info']['count'];

    await getMostPopulatedLocation();

    await getCharacters();

    isLoading = false;
  }

  sendRequest(String route, [Map<String,dynamic> parameters = const {}]) async {
    var url = Uri.https(apiUrl,route,parameters);

    var response = await http.get(url);

    failedRequest = response.statusCode != 200;

    var data = json.decode(response.body);

    return data;
  }

  Future<void> getMostPopulatedLocation() async {
    var data = await sendRequest('api/location');

    List locations = data['results'].toList();

    int previousCount = 0;
    String nameLocation = '';

    for (var location in locations) {
      if(location['residents'].length > previousCount){
        previousCount = location['residents'].length;
        nameLocation = location['name'];
      }
    }

    mostPopulatedLocation = nameLocation;
  }

  Future<void> getCharacters() async {
    _page++;

    var data = await sendRequest('api/character', {'page': '$_page'});

    infoCharacters = InfoCharactersModel.fromMap(data);

    paginate = _page < infoCharacters.info.pages;

    listCharacters.addAll(infoCharacters.results);

    _pendingRequest = false;

    notifyListeners();
  }

  @override
  void dispose()
  {
    super.dispose();
    scrollController.dispose();
  }
}