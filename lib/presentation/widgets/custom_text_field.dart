import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_dimension.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final FocusNode focusNode;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onTogglePassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.focusNode,
    this.isPassword = false,
    this.obscureText = false,
    this.onTogglePassword,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([focusNode, controller]),
      builder: (context, child) {
        final isFocused = focusNode.hasFocus;
        final hasText = controller.text.isNotEmpty;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
            gradient: LinearGradient(
              colors: (isFocused || hasText)
                  ? AppColors.primaryGradient
                  : [AppColors.transparent, AppColors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.fieldBackgroundColor,
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusSmall,
              ),
            ),
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              obscureText: isPassword && obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(color: AppColors.white),
              validator: validator,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: AppColors.white54),
                prefixIcon: Icon(prefixIcon, color: AppColors.white54),
                suffixIcon: isPassword
                    ? GestureDetector(
                        onTap: onTogglePassword,
                        child: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.white54,
                        ),
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusSmall,
                  ),
                  borderSide: const BorderSide(color: AppColors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusSmall,
                  ),
                  borderSide: const BorderSide(color: AppColors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusSmall,
                  ),
                  borderSide: const BorderSide(color: AppColors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusSmall,
                  ),
                  borderSide: const BorderSide(color: AppColors.red),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceS,
                  vertical: AppDimensions.spaceS,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
