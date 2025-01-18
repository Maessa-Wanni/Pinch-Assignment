import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/helpers/app_constants.dart';

import '../../../../core/helpers/local_storage.dart';

part 'splash_state.dart';


/// splash cubit
class SplashCubit extends Cubit<SplashState> {
  final LocalStorage localStorage;
  SplashCubit({required this.localStorage}) : super(SplashInitial());


  /// check the first app launch
  Future<bool> checkFirstLaunch() async {
    String isFirstTimeValue =
        await localStorage.readSecureData(AppConstants.firstTime);

    bool isFirstLaunch = isFirstTimeValue.isEmpty ||
            isFirstTimeValue == '' ||
            isFirstTimeValue.contains('No data found!')
        ? true
        : false;

    if (isFirstLaunch) {
      await localStorage.deleteAllSecureData();
      await localStorage.writeSecureData(AppConstants.firstTime, 'launched');
      return true;
    }
    return false;
  }

  Future<void> assignFirstTime() async {
    await localStorage.writeSecureData(AppConstants.firstTime, 'launched');
  }
}
