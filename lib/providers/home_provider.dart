import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:rick_and_morty_wiki_app/config/constants.dart';
import 'package:rick_and_morty_wiki_app/models/list_characters_model.dart';

class HomeProvider extends ChangeNotifier
{
  HomeProvider(){
    getData();
  }

  ScrollController scrollController = ScrollController();

  late ListCharactersModel characters;

  bool isLoading = true;

  int page = 0;

  int numEpisodes = 0;

  String mostPopulatedLocation = '';

  bool _pendingRequest = false;

  //List<>

  void init(){
    scrollController.addListener(() {
      if(scrollController.position.pixels ==
         scrollController.position.maxScrollExtent && !_pendingRequest)
      {
        print('if');
        getCharacters();
        _pendingRequest = true;
      }
    });
  }

  Future<void> getData() async {
    await getNumEpisodes();

    await getMostPopulatedLocation();

    await getCharacters();
  }

  Future<void> getNumEpisodes() async {
    var url = Uri.https(apiUrl,'api/episode');

    var response = await http.get(url);

    numEpisodes = json.decode(response.body)['info']['count'];
  }

  Future<void> getMostPopulatedLocation() async {
    var url = Uri.https(apiUrl, 'api/location');

    var response = await http.get(url);

    List data = json.decode(response.body)['results'].toList();

    int previousCount = 0;
    String nameLocation = '';

    for (var location in data) {
      if(location['residents'].length > previousCount){
        previousCount = location['residents'].length;
        nameLocation = location['name'];
      }
    }

    mostPopulatedLocation = nameLocation;
  }

  Future<void> getCharacters() async {
    isLoading = true;

    page++;

    var url = Uri.https(apiUrl,'api/character',{
      'page': '$page'
    });

    var response = await http.get(url);

    characters = ListCharactersModel.fromJson(response.body);

    isLoading = false;

    _pendingRequest = false;

    notifyListeners();
  }
}