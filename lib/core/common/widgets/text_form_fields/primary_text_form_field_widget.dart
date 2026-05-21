import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/assets.gen.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../utils/extensions.dart';
import 'text_field_content.dart';
import 'text_field_state.dart';

class PrimaryTextFormFieldWidget extends StatefulWidget {
  const PrimaryTextFormFieldWidget({
    required this.controller,
    required this.onChanged,
    required this.state,
    required this.contentType,
    required this.hintText,
    super.key,
    this.inputFormatter,
    this.validators,
    this.isBordered = false,
    this.readOnly = false,
    this.isDone = false,
    this.onTap,
    this.errorText,
    this.rightIconPath,
  });

  final TextEditingController controller;
  final String? Function(String?)? validators;
  final TextInputFormatter? inputFormatter;
  final ValueChanged<String?>? onChanged;
  final TextFieldState state;
  final TextFieldContent contentType;
  final String hintText;
  final VoidCallback? onTap;
  final bool isBordered;
  final bool readOnly;
  final bool isDone;
  final String? errorText;
  final String? rightIconPath;

  @override
  State<PrimaryTextFormFieldWidget> createState() =>
      _PrimaryTextFormFieldWidgetState();
}

class _PrimaryTextFormFieldWidgetState
    extends State<PrimaryTextFormFieldWidget> {
  bool _isActive = false;
  bool _isObscured = true;

  TextFieldState get effectiveState {
    if (_isActive) return TextFieldState.active;
    return widget.state;
  }

  TextFieldContent get effectiveContent {
    return widget.contentType;
  }

  bool getObscureText(TextFieldContent contentType) {
    if (contentType != TextFieldContent.password) return false;
    return _isObscured ? true : false;
  }

  TextInputType getKeyboardType(TextFieldContent contentType) {
    switch (contentType) {
      case TextFieldContent.name:
        return TextInputType.text;
      case TextFieldContent.email:
        return TextInputType.emailAddress;
      case TextFieldContent.password:
        return TextInputType.text;
    }
  }

  TextInputAction getTextInputAction(bool isDone) {
    switch (isDone) {
      case true:
        return TextInputAction.done;
      default:
        return TextInputAction.next;
    }
  }

  Widget getLeftIcon(TextFieldContent contentType) {
    switch (contentType) {
      case TextFieldContent.email:
        return Assets.icons.email.image(
          color: AppColors.hintTextFieldColor,
          width: 20.w,
          height: 20.h,
        );
      case TextFieldContent.password:
        return Assets.icons.openLock.image(
          color: AppColors.hintTextFieldColor,
          width: 20.w,
          height: 20.h,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildContent(
    BuildContext context,
    TextFieldContent contentType,
    bool isObscured,
  ) {
    if (contentType != TextFieldContent.password) return const SizedBox();
    return isObscured
        ? Icon(
          Icons.visibility_off,
          color: AppColors.secondaryTextColor,
          size: 20.r,
        )
        : Assets.icons.eye.image(
          width: 20.w,
          height: 20.h,
          color: AppColors.secondaryTextColor,
        );
  }

  @override
  Widget build(BuildContext context) {
    final focus = context.focus;

    return Column(
      children: [
        SizedBox(
          height: 50.h,
          child: TextFormField(
            controller: widget.controller,
            textInputAction: getTextInputAction(widget.isDone),
            onEditingComplete: () {
              focus.nextFocus();
              widget.state != TextFieldState.defaultState;
              _isActive = false;
            },
            onTap: widget.onTap,
            validator: widget.validators,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: widget.onChanged,
            onTapOutside: (event) {
              widget.state != TextFieldState.defaultState;
              _isActive = false;
              FocusManager.instance.primaryFocus?.unfocus();
            },
            obscureText: getObscureText(effectiveContent),
            keyboardType: getKeyboardType(effectiveContent),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(
                  color: AppColors.borderTextFieldColor,
                  width: 1.w,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.borderTextFieldColor,
                  width: 1.w,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.borderTextFieldColor,
                  width: 1.w,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: AppTextStyles.subtitle.copyWith(
                color: AppColors.hintTextFieldColor,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: getLeftIcon(widget.contentType),
              ),
              prefixIconColor: AppColors.hintTextFieldColor,
              suffixIcon: InkWell(
                onTap: () {
                  if (widget.state != TextFieldState.active) {
                    setState(() {
                      _isActive = true;
                      if (widget.contentType == TextFieldContent.password) {
                        _isObscured = !_isObscured;
                      }
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: _buildContent(context, effectiveContent, _isObscured),
                ),
              ),
              suffixIconColor: AppColors.hintTextFieldColor,
            ),
          ),
        ),
      ],
    );
  }
}
