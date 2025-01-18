import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../data/datasources/games_webservice.dart';
import '../../domain/repositories/games_repo.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/empty_response.dart';
import '../datasources/game_local_datasource.dart';
import '../models/game_model.dart';

class GamesRepoImpl extends GamesRepo {
  final GamesWebService gamesWebservice;
  final GamesLocalDatasource gamesLocalDatasource;

  GamesRepoImpl(this.gamesWebservice, this.gamesLocalDatasource);

  @override
  Future<Either<EmptyResponse, List<GameModel>>> getGamesData(int offset,
      {int limit = 10}) async {
    try {
      var result = await gamesWebservice.getGamesData(offset);
      if (result.statusCode == 200) {
        List<GameModel> games =
            (result.data as List).map((e) => GameModel.fromJson(e)).toList();
        await gamesLocalDatasource.storeGameData(games);
        return right(games);
      } else {
        return left(EmptyResponse(errors: result.data));
      }
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<EmptyResponse, List<GameModel>>> getGamesDataLocally(int offset,
      {int limit = 10}) async {
    try {
      log("We are trying to get games from local");
      var result = await gamesLocalDatasource.fetchGameData(offset);
      if (result is List<GameModel>) {
        return right(result);
      } else {
        return left(ErrorHandler.handle(result).failure);
      }
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }
}
