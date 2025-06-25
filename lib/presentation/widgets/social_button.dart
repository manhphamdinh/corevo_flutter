import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_dimension.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imagePath;

  const SocialButton({Key? key, required this.onTap, required this.imagePath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimensions.socialButtonSize,
        height: AppDimensions.socialButtonSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: AppColors.transparent,
          child: Image.asset(
            imagePath,
            width: AppDimensions.socialIconSize,
            height: AppDimensions.socialIconSize,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
