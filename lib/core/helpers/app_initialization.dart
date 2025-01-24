import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependancy_injection.dart';

import '../../../my_app.dart';

import 'bloc_observer.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> appInitialization() async {

  /*Ensures that Flutter’s binding system is initialized before calling native code or running the app.
  Required for operations like plugin initialization or making calls to platform channels before runApp.*/

  WidgetsFlutterBinding.ensureInitialized();

  /*Assigns a custom MyBlocObserver to monitor and log Bloc events, transitions, and errors.
  Purpose: Helps with debugging and understanding state changes in the application.*/
  Bloc.observer = MyBlocObserver();

  /*Calls a setup function for dependency injection.
  setupGetIt is likely a method that registers services, repositories, or providers into a DI container (e.g., GetIt).
  Purpose: Manages dependencies efficiently, promoting decoupled and testable code.*/
  await setupGetIt();

  runApp(
    const MyApp(),
  );
}
