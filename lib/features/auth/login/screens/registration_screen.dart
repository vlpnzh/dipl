import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/common/widgets/buttons/primary_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../gen/assets.gen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isRecommendationsEnabled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                context.locale!.createAccount,
                style: AppTextStyles.title.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.locale!.manageFinances,
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.secondaryTextColor,
                ),
              ),
              SizedBox(height: 32.h),
              _buildInputField(
                label: context.locale!.fullName,
                hint: context.locale!.inputName,
                controller: _nameController,
              ),
              SizedBox(height: 20.h),
              _buildInputField(
                label: context.locale!.email,
                hint: 'example@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.h),
              _buildInputField(
                label: context.locale!.password,
                hint: context.locale!.minSymbols,
                controller: _passwordController,
                obscureText: _isPasswordObscured,
                suffixIcon: IconButton(
                  onPressed:
                      () => setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      }),
                  icon:
                      _isPasswordObscured
                          ? Assets.icons.eye.image(width: 24.w, height: 24.h)
                          : Assets.icons.eye.image(width: 24.w, height: 24.h),
                ),
              ),
              SizedBox(height: 24.h),
              _buildRecommendationsTile(),
              SizedBox(height: 32.h),
              PrimaryButton(
                title: context.locale!.continueOnboarding,
                bgColor: AppColors.primaryColor,
                textColor: AppColors.white,
                onPressed: () {},
              ),
              SizedBox(height: 24.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.hintRegister.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                    children: [
                      TextSpan(text: context.locale!.haveAccount),
                      TextSpan(
                        text: context.locale!.login,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer:
                            TapGestureRecognizer()..onTap = () => context.pop(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.h2Headline.copyWith(
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyles.hintText.copyWith(color: AppColors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.hintText.copyWith(
              color: AppColors.hintTextFieldColor,
            ),
            filled: true,
            fillColor: AppColors.transactionsScreenBg,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 18.h,
            ),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColors.borderTextFieldColor,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationsTile() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.callCenterBGColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.locale!.onSmartFunctions,
              style: AppTextStyles.hintRegister.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Switch.adaptive(
            value: _isRecommendationsEnabled,
            activeTrackColor: AppColors.primaryColor,
            inactiveTrackColor: AppColors.progressIndicatorColor,
            onChanged: (value) {
              setState(() => _isRecommendationsEnabled = value);
            },
          ),
        ],
      ),
    );
  }
}
