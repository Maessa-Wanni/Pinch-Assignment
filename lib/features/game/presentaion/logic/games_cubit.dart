import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../../core/networking/api_urls.dart';
import '../../data/models/game_model.dart';
import '../../data/repository/games_repo_impl.dart';

part 'games_state.dart';

/// game cubit
class GamesCubit extends Cubit<GamesState> {
  final GamesRepoImpl gamesRepoImpl;

  GamesCubit(this.gamesRepoImpl) : super(GamesInitial());

  List<GameModel>? gamesResponse;
  List<GameModel> games = [];

  Future<void> resetGames() async {
    games = []; // Clear the games list
    gamesResponse = []; // Reset the cached response
    emit(GamesInitial()); // Emit the initial state
  }

  Future<void> checkSource(int offset, {int limit = 10}) async {
    ///check if there is data in the local source
    /// display games from local source
    /// gamesResponse = response from local source

    /// get games from remote source
    if (await InternetConnection().hasInternetAccess) {
      await getGamesData(offset, limit: limit);
    } else {
      /// Fetch game from data
      await getGamesData(offset, limit: limit, isLocal: true);
    }
  }

  Future<void> getGamesData(int offset,
      {int limit = 10, bool isLocal = false}) async {
    /// delete local source all data
    emit(GetGamesDataLoading());
    var result = isLocal
        ? await gamesRepoImpl.getGamesDataLocally(offset, limit: limit)
        : await gamesRepoImpl.getGamesData(offset, limit: limit);
    log(result.toString());
    result.fold(
      (l) => emit(
          GetGamesDataError(l.errors?.first.title ?? ApiErrors.defaultError)),
      (r) {
        gamesResponse = r;
        if (r != null) {
          games.addAll(r);
        }

        /// store it locally

        emit(GetGamesDataSuccess(r));
      },
    );
  }
}
