import 'package:Pinch_assignment/features/game/data/models/game_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class GamesDao {
  @Query('SELECT * FROM GameEntity LIMIT :limit OFFSET :offset')
  Future<List<GameEntity>> getPaginatedGames(int offset, {int limit = 10});

  @insert
  Future<void> insertGame(GameEntity game);

  @insert
  Future<void> insertGames(List<GameEntity> games);

  @delete
  Future<void> deleteGame(GameEntity game);

  @Query('DELETE FROM GameEntity')
  Future<void> deleteGames();
}
