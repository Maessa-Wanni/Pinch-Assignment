import 'package:dartz/dartz.dart';

import '../../data/models/game_model.dart';

import '../../../../core/networking/empty_response.dart';


/// games repository
abstract class GamesRepo {
  Future<Either<EmptyResponse, List<GameModel>>> getGamesData(int offset, {int limit =10});
  Future<Either<EmptyResponse, List<GameModel>>> getGamesDataLocally(int offset, {int limit =10});

}
