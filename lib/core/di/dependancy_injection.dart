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

/*
Purpose: Creates a singleton instance of GetIt, the DI container used to manage and access registered services globally.
*/
final getIt = GetIt.instance;

/*Configures and registers dependencies in the GetIt DI container.*/
Future<void> setupGetIt() async {
  //Dio $ ApiService
  /*
   Creates a Dio instance using the DioFactory class. Likely configured for API requests (e.g., base URL, interceptors).
   */
  Dio dio = await DioFactory.getDio();
  /*Builds and initializes a Floor database named flutter_database.db.*/
  final database = await $FloorFlutterDatabase
      .databaseBuilder('flutter_database.db')
      .build();
  /*Retrieves the GamesDao instance for managing game-related database operations.*/
  final GamesDao gamesDao = database.gameDao;
  // database.g
  /*
  Registers gamesDao as a singleton, meaning a single instance will be used throughout the app.
  */
  getIt.registerSingleton(gamesDao);
  /*
  Registers LocalStorage as a lazy singleton, meaning it is initialized only when first accessed.
  */
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
