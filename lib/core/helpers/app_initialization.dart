import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependancy_injection.dart';

import '../../../my_app.dart';

import '../../features/game/data/models/database.dart';
import 'bloc_observer.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> appInitialization() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final database = await $FloorFlutterDatabase
  //     .databaseBuilder('flutter_database.db')
  //     .build();
  //  final gameDao = database.gameDao;
  Bloc.observer = MyBlocObserver();
  await setupGetIt();

  runApp(
    const MyApp(),
  );
}
