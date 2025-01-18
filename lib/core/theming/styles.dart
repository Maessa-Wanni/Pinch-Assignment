import 'package:flutter/material.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/font_weight_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// app text styleS
class TextStyles {
  static TextStyle font18BlackBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
    fontFamily: 'Somar',
  );

  static TextStyle font18BlackRegular = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
    fontFamily: 'Somar',
  );

  static TextStyle font18BlackSemiBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.mainColor,
    fontFamily: 'Somar',
  );

  static TextStyle font16WhiteBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
    fontFamily: 'Somar',
  );

  static TextStyle font16GrayRegular = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    fontFamily: 'Somar',
    color: ColorsManager.gray,
  );
}
