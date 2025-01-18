import 'dart:convert';

import 'game_entity.dart';

class GameModel {
  int? id;
  List<AgeRatings>? ageRatings;
  List<AlternativeNames>? alternativeNames;
  Cover? cover;
  String? name;
  List<Cover>? screenshots;
  String? slug;
  String? storyline;
  String? summary;
  List<Websites>? websites;
  List<GameLocalizations>? gameLocalizations;

  GameModel(
      {this.id,
      this.ageRatings,
      this.alternativeNames,
      this.cover,
      this.name,
      this.screenshots,
      this.slug,
      this.storyline,
      this.summary,
      this.websites,
      this.gameLocalizations});

  GameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['age_ratings'] != null) {
      ageRatings = <AgeRatings>[];
      json['age_ratings'].forEach((v) {
        ageRatings!.add(AgeRatings.fromJson(v));
      });
    }
    if (json['alternative_names'] != null) {
      alternativeNames = <AlternativeNames>[];
      json['alternative_names'].forEach((v) {
        alternativeNames!.add(AlternativeNames.fromJson(v));
      });
    }
    cover = json['cover'] != null ? Cover.fromJson(json['cover']) : null;
    name = json['name'];
    if (json['screenshots'] != null) {
      screenshots = <Cover>[];
      json['screenshots'].forEach((v) {
        screenshots!.add(Cover.fromJson(v));
      });
    }
    slug = json['slug'];
    storyline = json['storyline'];
    summary = json['summary'];
    if (json['websites'] != null) {
      websites = <Websites>[];
      json['websites'].forEach((v) {
        websites!.add(Websites.fromJson(v));
      });
    }
    if (json['game_localizations'] != null) {
      gameLocalizations = <GameLocalizations>[];
      json['game_localizations'].forEach((v) {
        gameLocalizations!.add(GameLocalizations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (ageRatings != null) {
      data['age_ratings'] = ageRatings!.map((v) => v.toJson()).toList();
    }
    if (alternativeNames != null) {
      data['alternative_names'] =
          alternativeNames!.map((v) => v.toJson()).toList();
    }
    if (cover != null) {
      data['cover'] = cover!.toJson();
    }
    data['name'] = name;
    if (screenshots != null) {
      data['screenshots'] = screenshots!.map((v) => v.toJson()).toList();
    }
    data['slug'] = slug;
    data['storyline'] = storyline;
    data['summary'] = summary;
    if (websites != null) {
      data['websites'] = websites!.map((v) => v.toJson()).toList();
    }
    if (gameLocalizations != null) {
      data['game_localizations'] =
          gameLocalizations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AgeRatings {
  int? id;
  int? category;
  int? rating;
  String? checksum;

  AgeRatings({this.id, this.category, this.rating, this.checksum});

  AgeRatings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    rating = json['rating'];
    checksum = json['checksum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['rating'] = rating;
    data['checksum'] = checksum;
    return data;
  }
}

class AlternativeNames {
  int? id;
  String? name;

  AlternativeNames({this.id, this.name});

  AlternativeNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Cover {
  int? id;
  String? url;

  Cover({this.id, this.url});

  Cover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}

class Websites {
  int? id;
  int? category;
  int? game;
  bool? trusted;
  String? url;
  String? checksum;

  Websites(
      {this.id,
      this.category,
      this.game,
      this.trusted,
      this.url,
      this.checksum});

  Websites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    game = json['game'];
    trusted = json['trusted'];
    url = json['url'];
    checksum = json['checksum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['game'] = game;
    data['trusted'] = trusted;
    data['url'] = url;
    data['checksum'] = checksum;
    return data;
  }
}

class GameLocalizations {
  int? id;
  String? name;

  GameLocalizations({this.id, this.name});

  GameLocalizations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

extension GameModelToEntity on GameModel {
  GameEntity toEntity() {
    return GameEntity(
      id ?? 0,
      name ?? '',
      summary ?? '',
      storyline ?? '',
      slug ?? '',
      alternativeNames != null
          ? jsonEncode(alternativeNames)
          : '',
      screenshots != null
          ? jsonEncode(screenshots)
          : '',
      cover != null ? jsonEncode(cover) :'',
      ageRatings != null
          ? jsonEncode(ageRatings)
          : '',
      websites != null
          ? jsonEncode(websites)
          : '',
      gameLocalizations != null
          ? jsonEncode(gameLocalizations)
          : '',
    );
  }
}

extension GameModelListToEntity on List<GameModel> {
  List<GameEntity> toEntityList() {
    return map((model) => model.toEntity()).toList();
  }
}
