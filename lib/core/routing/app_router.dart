import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/dependancy_injection.dart';
import '../../../core/routing/routes.dart';
import '../../../features/splash/presentation/logic/splash_cubit.dart';
import '../../features/game/presentaion/screens/games_screen.dart';
import '../../features/game/presentaion/logic/games_cubit.dart';
import '../../../features/splash/presentation/screens/onboarding_screen.dart';
import '../../../features/splash/presentation/screens/splash_screen.dart';
/// app Router
class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SplashCubit>(),
            child: const SplashScreen(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GamesCubit>(),
            child: const GamesScreen(),
          ),
        );
      case Routes.onBoardingScreen1:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
           create: (context) => getIt<SplashCubit>(),
            child: const OnboardingScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
