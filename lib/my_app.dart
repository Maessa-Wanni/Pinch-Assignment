import 'package:flutter/material.dart';
import '../../../core/helpers/app_initialization.dart';
import '../../../core/helpers/app_texts.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/routing/routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (ctx, orientation, screenType) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
