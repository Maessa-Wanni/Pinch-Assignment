import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../features/splash/presentation/logic/splash_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// splash screen
class SplashScreen extends StatefulWidget {
  final bool getData;
  const SplashScreen({super.key, this.getData = false});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  /// check if the first time launch
  checkFirstTime() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        bool isFirstTime = await context.read<SplashCubit>().checkFirstLaunch();
        goTo(isFirstTime);
      },
    );
  }

  goTo(bool isFirstTime) {
    if (isFirstTime) {
       context.pushReplacementNamed(
      /// Routes.startScreen,
      Routes.onBoardingScreen1,
    );
    } else {
       context.pushReplacementNamed(
      /// Routes.startScreen,
      Routes.homeScreen,
    );
    }
    
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await checkFirstTime();
    });

    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    final Animation<double> curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    /// Define the tween
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(curve);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          goTo(false);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      width: 50.w,
                      height: 30.h,
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Image.asset(AssetsConstants.fullLogo),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
