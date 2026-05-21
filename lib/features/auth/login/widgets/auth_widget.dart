import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/utils/extensions.dart';
import '../../../../core/common/widgets/text_form_fields/primary_text_form_field_widget.dart';
import '../../../../core/common/widgets/text_form_fields/text_field_content.dart';
import '../../../../core/common/widgets/text_form_fields/text_field_state.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({
    required TextEditingController emailController,
    required TextEditingController passwordController,
    super.key,
  }) : _emailController = emailController,
       _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextFormFieldWidget(
          controller: _emailController,
          onChanged: (String? value) {},
          state: TextFieldState.defaultState,
          contentType: TextFieldContent.email,
          hintText: context.locale!.email,
        ),
        16.verticalSpace,
        PrimaryTextFormFieldWidget(
          controller: _passwordController,
          onChanged: (String? value) {},
          state: TextFieldState.defaultState,
          contentType: TextFieldContent.password,
          hintText: context.locale!.password,
          isDone: true,
        ),
      ],
    );
  }
}
