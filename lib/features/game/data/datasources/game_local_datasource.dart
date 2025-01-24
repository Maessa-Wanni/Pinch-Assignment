import 'dart:developer';

import 'package:Pinch_assignment/features/game/data/models/game_dao.dart';

import '../models/game_model.dart';

class GamesLocalDatasource {
  final GamesDao gamesDao;

  // final DAO localDatabase;
  const GamesLocalDatasource(this.gamesDao);

  // store datasources in local database

  Future<void> storeGameData(List<GameModel> gameModels) async {
    log(" we are going to insert your games locally with length ${gameModels.length}");
    // Convert the list of GameModel to a list of GameEntity
    final gameEntities = gameModels.toEntityList();

    // Store the data in the database using the DAO
    await gamesDao
        .insertGames(gameEntities)
        .onError((error, stackTrace) => log(error.toString()));

    // Print a confirmation message
    log('Games have been successfully saved to the database.');
  }

  Future<List<GameModel>> fetchGameData(int offset, {int limit = 10}) async {
    // Build the database

    // Fetch the data from the database

    // await gamesDao.deleteGames();
    // return [];

    final gameEntities = await gamesDao.getPaginatedGames(offset, limit: limit);
    final gameModels = gameEntities.map((gameEntity) {
      // log(gameEntity.toString());
      return gameEntity.toModel();
    }).toList();

    return gameModels;
  }

  Future<void> deleteGameData() async {
    await gamesDao.deleteGames();
  }
}
