import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/common/utils/extensions.dart';
import '../../../core/common/widgets/buttons/primary_button.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../gen/assets.gen.dart';
import '../widgets/custom_progress_indicator.dart';
import '../widgets/tab_ob.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  void _nextPage() {
    switch (_currentIndex) {
      case 3:
        context.go(AppRoutes.login.path);
      default:
        setState(() {
          _currentIndex++;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      TabOb(
        icon: Assets.icons.ob0.image(width: 28.5.w, height: 22.63.h),
        inColor: AppColors.ob0In,
        outColor: AppColors.ob0Out,
        title: context.locale!.onboardingTitle0,
        text: context.locale!.onboardingText0,
      ),
      TabOb(
        icon: Assets.icons.ob1.image(width: 28.5.w, height: 22.63.h),
        inColor: AppColors.ob1In,
        outColor: AppColors.ob1Out,
        title: context.locale!.onboardingTitle1,
        text: context.locale!.onboardingText1,
      ),
      TabOb(
        icon: Assets.icons.ob2.image(width: 28.5.w, height: 22.63.h),
        inColor: AppColors.ob2In,
        outColor: AppColors.ob2Out,
        title: context.locale!.onboardingTitle2,
        text: context.locale!.onboardingText2,
      ),
      TabOb(
        icon: Assets.icons.ob3.image(width: 28.5.w, height: 22.63.h),
        inColor: AppColors.ob0In,
        outColor: AppColors.ob0Out,
        title: context.locale!.onboardingTitle3,
        text: context.locale!.onboardingText3,
      ),
    ];

    final List<Widget> keyedScreens =
        screens
            .asMap()
            .map(
              (index, screen) => MapEntry(
                index,
                Container(key: ValueKey<int>(index), child: screen),
              ),
            )
            .values
            .toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login.path),
                    child: Text(
                      context.locale!.skip,
                      style: AppTextStyles.h1Headline.copyWith(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOutQuart,
                switchOutCurve: Curves.easeInOutQuart,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  var offsetTween = Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation);
                  if (child.key == ValueKey<int>(_currentIndex)) {
                    return SlideTransition(position: offsetTween, child: child);
                  } else {
                    // Якщо це віджет, що ВИХОДИТЬ
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: ClipRect(child: child),
                    );
                  }
                },
                layoutBuilder: (
                  Widget? currentChild,
                  List<Widget> previousChildren,
                ) {
                  return Stack(
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                child: keyedScreens[_currentIndex],
              ),
              const Spacer(),
              CustomProgressIndicatorIndicator(
                currentStep: _currentIndex,
                totalSteps: 4,
              ),
              16.verticalSpace,
              PrimaryButton(
                onPressed: _nextPage,
                bgColor: AppColors.primaryColor,
                textColor: AppColors.white,
                title: context.locale!.continueOnboarding,
                rightIcon: Assets.icons.arrowRight.image(width: 32.w),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
