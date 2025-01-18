import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/app_constants.dart';
import '../../../../core/helpers/app_texts.dart';
import '../../../../core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../features/splash/presentation/logic/splash_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


/// onboarding screen for first launch
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 6,
            child: Image.asset(
              AssetsConstants.onboardImage,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        AppTexts.onboardDescription,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyles.font16WhiteBold.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.gray3,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AppTextButton(
                      horizontalPadding: 0,
                      verticalPadding: 0.1,
                      buttonText: AppTexts.gettingStarted,
                      textStyle: TextStyles.font16WhiteBold,
                      borderRadius: 10.w,
                      onPressed: () async {
                        await context.read<SplashCubit>().assignFirstTime();
                        context.pushReplacementNamed(
                          Routes.homeScreen,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
