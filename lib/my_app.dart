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

        ////A global key used to control navigation
        //It allows global navigation control without relying solely on the context.
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: AppTexts.appName,
        initialRoute: Routes.splashScreen,
        ////A function that dynamically generates routes based on the requested navigation path.
        //It allows defining complex navigation logic dynamically, instead of using static route mappings.
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
