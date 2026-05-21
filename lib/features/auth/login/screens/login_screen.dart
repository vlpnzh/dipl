import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/common/widgets/buttons/app_text_button.dart';
import '../../../../core/common/widgets/buttons/primary_button.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../gen/assets.gen.dart';
import '../widgets/auth_widget.dart';
import '../widgets/divider_widget.dart';
import '../widgets/social_buttons_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                56.verticalSpace,
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  ),
                  child: Assets.icons.closedLock.image(
                    width: 32.w,
                    height: 32.h,
                    color: AppColors.white,
                  ),
                ),
                33.verticalSpace,
                Text(
                  context.locale!.welcomeBackAgain,
                  style: AppTextStyles.title,
                ),
                Text(
                  context.locale!.logInToYourAccount,
                  style: AppTextStyles.subtitle.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                41.verticalSpace,
                AuthWidget(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                14.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextButton(
                      text: context.locale!.forgotPassword,
                      onTap: () {},
                    ),
                  ],
                ),
                14.verticalSpace,
                PrimaryButton(
                  bgColor: AppColors.primaryColor,
                  textColor: AppColors.white,
                  title: context.locale!.login,
                  onPressed: () => context.go(AppRoutes.home.path),
                ),
                24.verticalSpace,
                const DividerWidget(),
                24.verticalSpace,
                const SocialButtonsWidget(),
                14.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.locale!.dontHaveAccount,
                      style: AppTextStyles.hintRegister.copyWith(
                        color: AppColors.hintTextFieldColor,
                      ),
                    ),
                    AppTextButton(
                      text: context.locale!.signUp,
                      onTap: () => context.push(AppRoutes.registration.path),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
