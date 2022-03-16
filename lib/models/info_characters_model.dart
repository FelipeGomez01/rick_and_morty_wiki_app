import 'dart:convert';

import 'character_model.dart';

class InfoCharactersModel {
  InfoCharactersModel({
    required this.info,
    required this.results,
  });

  final Info info;
  final List<CharacterModel> results;

  factory InfoCharactersModel.fromJson(String str) => InfoCharactersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoCharactersModel.fromMap(Map<String, dynamic> json) => InfoCharactersModel(
    info: Info.fromMap(json["info"]),
    results: List<CharacterModel>.from(json["results"].map((x) => CharacterModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "info": info.toMap(),
    "results": List<dynamic>.from(results.map((x) => x.toMap())),
  };
}

class Info {
  Info({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  final int count;
  final int pages;
  final String next;
  final dynamic prev;

  factory Info.fromJson(String str) => Info.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );

  Map<String, dynamic> toMap() => {
    "count": count,
    "pages": pages,
    "next": next,
    "prev": prev,
  };
}
