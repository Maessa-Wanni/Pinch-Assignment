import 'package:Pinch_assignment/features/game/data/datasources/games_webservice.dart';
import 'package:Pinch_assignment/features/game/data/models/game_dao.dart';
import 'package:Pinch_assignment/features/game/data/repository/games_repo_impl.dart';
import 'package:Pinch_assignment/features/game/presentaion/logic/games_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../../core/helpers/local_storage.dart';
import '../../../features/splash/presentation/logic/splash_cubit.dart';
import '../../features/game/data/datasources/game_local_datasource.dart';
import '../networking/api_service.dart';
import '../networking/dio_factory.dart';
import '../../features/game/data/models/database.dart';
final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //Dio $ ApiService

  Dio dio = await DioFactory.getDio();
  final database = await $FloorFlutterDatabase
      .databaseBuilder('flutter_database.db')
      .build();
  final GamesDao gamesDao = database.gameDao;
  // database.g
  getIt.registerSingleton(gamesDao);

  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  //splash
  getIt.registerFactory<SplashCubit>(() => SplashCubit(localStorage: getIt()));
  //ApiServiceClient instance
  getIt.registerLazySingleton<ApiService>(() => ApiService(
        dio,
        getIt(),
      ));

  // games
  getIt.registerLazySingleton<GamesWebService>(
    () => GamesWebService(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<GamesLocalDatasource>(
    () => GamesLocalDatasource(
      getIt(),
    ),
  );
  getIt.registerLazySingleton<GamesRepoImpl>(
    () => GamesRepoImpl(
      getIt(),
      getIt(),
    ),
  );
  getIt.registerFactory<GamesCubit>(
    () => GamesCubit(
      getIt(),
    ),
  );
}
