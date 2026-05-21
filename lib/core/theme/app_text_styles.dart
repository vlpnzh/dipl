import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  //h1 Headline
  static final h1Headline = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  //h2 Headline
  static final h2Headline = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  //appBar
  static final appBar = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );

  //title
  static final title = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
  );

  //subtitle
  static final subtitle = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  //hintText
  static final hintText = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  //dividerText
  static final dividerText = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  );

  //socialText
  static final socialText = TextStyle(
    fontFamily: 'SF Compact',
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  //hintRegister
  static final hintRegister = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  //amount
  static final amount = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 36.sp,
    fontWeight: FontWeight.w600,
  );

  static final amountMain = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  //targets
  static final targets = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static final targetsLabel = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static final targetsPercent = TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
  );
}
