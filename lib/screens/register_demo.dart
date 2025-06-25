import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_dimension.dart';
import 'package:flutter_application_1/core/constants/app_string.dart';
import 'package:flutter_application_1/presentation/widgets/custom_text_field.dart';
import 'package:flutter_application_1/presentation/widgets/gradient_button.dart';
import 'package:flutter_application_1/presentation/widgets/social_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/validators.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.spaceXXL),
                _buildBackButton(),
                _buildTitle(),
                const SizedBox(height: AppDimensions.spaceXL),
                _buildFormFields(),
                const SizedBox(height: AppDimensions.spaceXL),
                _buildLoginButton(),
                const SizedBox(height: 40),
                _buildDivider(),
                const SizedBox(height: AppDimensions.spaceXXL),
                _buildSocialButtons(),
                const SizedBox(height: 27),
                _buildRegisterLink(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(
        Icons.arrow_back_ios,
        color: AppColors.white,
        size: AppDimensions.backIconSize,
      ),
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        AppStrings.loginButton,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          hintText: AppStrings.phoneOrEmail,
          prefixIcon: Icons.email_outlined,
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: AppDimensions.spaceM),
        CustomTextField(
          controller: _passwordController,
          hintText: AppStrings.password,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          obscureText: _obscurePassword,
          onTogglePassword: () =>
              setState(() => _obscurePassword = !_obscurePassword),
          focusNode: _passwordFocusNode,
          validator: Validators.validatePassword,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return GradientButton(
      text: AppStrings.loginButton,
      onPressed: _handleLogin,
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.white30)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceS),
          child: Text(
            AppStrings.orSignInWith,
            style: TextStyle(color: AppColors.white70, fontSize: 16),
          ),
        ),
        Expanded(child: Divider(color: AppColors.white30)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          onTap: _handleGoogleSignIn,
          imagePath: 'assets/images/google_icon.png',
        ),
        const SizedBox(width: 27),
        SocialButton(
          onTap: _handleFacebookSignIn,
          imagePath: 'assets/images/facebook_icon.png',
        ),
      ],
    );
  }

  Widget _buildRegisterLink() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen()),
        ),
        child: const Text.rich(
          TextSpan(
            text: 'Chưa có tài khoản? ',
            style: TextStyle(color: AppColors.white70, fontSize: 16),
            children: [
              TextSpan(
                text: AppStrings.register,
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
      print('Login: ${_emailController.text}');
    }
  }

  void _handleGoogleSignIn() {
    // TODO: Implement Google sign in
    print('Google login pressed');
  }

  void _handleFacebookSignIn() {
    // TODO: Implement Facebook sign in
    print('Facebook login pressed');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
