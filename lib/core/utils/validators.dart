import 'package:flutter_application_1/core/constants/app_string.dart';

class Validators {
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.pleaseEnterFullName;
    }
    if (value.trim().length < 2) {
      return AppStrings.fullNameTooShort;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.pleaseEnterEmailOrPhone;
    }

    // Basic email validation
    if (value.contains('@')) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return AppStrings.invalidEmail;
      }
    } else {
      // Basic phone validation
      final phoneRegex = RegExp(r'^[0-9]{10,11}$');
      if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[^\d]'), ''))) {
        return AppStrings.invalidPhone;
      }
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.pleaseEnterUsername;
    }
    if (value.trim().length < 3) {
      return AppStrings.usernameTooShort;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterPassword;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseConfirmPassword;
    }
    if (value != password) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }
}
