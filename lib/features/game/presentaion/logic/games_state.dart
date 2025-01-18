part of 'games_cubit.dart';

/// state of the game
abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object> get props => [];
}
/// initialize
class GamesInitial extends GamesState {}

/// loading
class GetGamesDataLoading extends GamesState {}

/// success
class GetGamesDataSuccess extends GamesState {
  final List<GameModel> gamesResponse;
  const GetGamesDataSuccess(this.gamesResponse);
  @override
  List<Object> get props => [gamesResponse];
}

/// error
class GetGamesDataError extends GamesState {
  final String errorMessage;
  const GetGamesDataError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
