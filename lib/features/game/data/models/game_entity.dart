// entity/person.dart

import 'dart:convert';

import 'package:floor/floor.dart';

import 'game_model.dart';

@entity
class GameEntity {
  @primaryKey
  final int id;

  final String name;
  final String summary,
      storyline,
      slug,
      screenshots,
      cover,
      alternativeNames,
      ageRatings,
      websites,
      gameLocalizations;

  GameEntity(
      this.id,
      this.name,
      this.summary,
      this.storyline,
      this.slug,
      this.alternativeNames,
      this.screenshots,
      this.cover,
      this.ageRatings,
      this.websites,
      this.gameLocalizations);

  // Method to convert GameEntity to GameModel
  GameModel toModel() {

    return GameModel(
      id: id,
      name: name,
      summary: summary,
      storyline: storyline,
      slug: slug,
      screenshots: _parseScreenshots(screenshots),
      cover: _parseCover(cover),
      alternativeNames: _parseAlternativeNames(alternativeNames),
      ageRatings: _parseAgeRatings(ageRatings),
      websites: _parseWebsites(websites),
      gameLocalizations: _parseGameLocalizations(gameLocalizations),
    );
  }
  @override
    String toString() {
    return 'GameEntity{\n\tid: $id,\n name: $name,\n slug: $slug,\n screenshots: $screenshots,\n cover: $cover,\n alternativeNames: $alternativeNames,\n ageRatings: $ageRatings,\n websites: $websites,\n gameLocalizations: $gameLocalizations\n}';
  }

  List<Cover>? _parseScreenshots(String jsonString) {
    if (jsonString.isEmpty) return null;
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Cover.fromJson(e)).toList();
  }

  Cover? _parseCover(String jsonString) {
    if (jsonString.isEmpty) return null;
    return Cover.fromJson(json.decode(jsonString));
  }

  List<AlternativeNames>? _parseAlternativeNames(String jsonString) {
    if (jsonString.isEmpty) return null;
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => AlternativeNames.fromJson(e)).toList();
  }

  List<AgeRatings>? _parseAgeRatings(String jsonString) {
    if (jsonString.isEmpty) return null;
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => AgeRatings.fromJson(e)).toList();
  }

  List<Websites>? _parseWebsites(String jsonString) {
    if (jsonString.isEmpty) return null;
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Websites.fromJson(e)).toList();
  }

  List<GameLocalizations>? _parseGameLocalizations(String jsonString) {
    if (jsonString.isEmpty) return null;
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => GameLocalizations.fromJson(e)).toList();
  }



}
