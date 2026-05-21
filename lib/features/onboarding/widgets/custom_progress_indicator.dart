import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class CustomProgressIndicatorIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CustomProgressIndicatorIndicator({
    required this.currentStep,
    required this.totalSteps,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = AppColors.primaryColor;
    const inactiveColor = AppColors.progressIndicatorColor;

    double activeWidth = 33.w;
    double inactiveWidth = 8.w;
    double barHeight = 8.h;
    double spacing = 10.w;

    Duration animationDuration = const Duration(milliseconds: 300);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalSteps, (index) {
        final bool isActive = index == currentStep;

        return Padding(
          padding: EdgeInsets.only(
            right: index == totalSteps - 1 ? 0 : spacing,
          ),
          child: AnimatedContainer(
            duration: animationDuration,
            width: isActive ? activeWidth : inactiveWidth,
            height: barHeight,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(barHeight / 2),
            ),
          ),
        );
      }),
    );
  }
}
