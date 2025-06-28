import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/presentation/blocs/register_cubit.dart';
import 'package:flutter_application_1/services/shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/widgets/auth_custom_button.dart';
import 'package:flutter_application_1/presentation/widgets/button_gg_fb_auth.dart';
import 'package:flutter_application_1/presentation/widgets/custom_input_field.dart';
import 'package:flutter_application_1/presentation/widgets/text_bottom_auth.dart';
import 'package:flutter_application_1/core/constants/app_string.dart';
import 'package:flutter_application_1/core/constants/app_color.dart';
import 'package:flutter_application_1/core/constants/app_dimension.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstnameController = TextEditingController(); //Tên
  final _lastnameController = TextEditingController(); //Họ
  bool _isPasswordVisible = false;
  bool _agree = false; // đã tick checkbox?
  bool isLoading = false; // hiển thị CircularProgressIndicator?

  // Thêm hàm _showSnackBar
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        // Thêm BlocListener để lắng nghe AuthState
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              _showSnackBar(state.message ?? 'Đăng ký thành công!');
              // Navigate to OTP verification screen với email
              Navigator.pushNamed(
                context,
                '/otp-verification',
                arguments: _emailController.text.trim(),
              );
            } else if (state is AuthFailure) {
              _showSnackBar(state.message, isError: true);
            }
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    width: screenWidth,
                    height: 135,
                    decoration: const BoxDecoration(color: Color(0xFF2454F8)),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // 👈 quan trọng

                      children: [
                        const SizedBox(height: AppDimensions.spaceXL),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: _buildBackButton(),
                        ),
                        const SizedBox(height: AppDimensions.spaceXS),
                        Center(child: _buildTitle()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: AppDimensions.spaceXL),
                        _buildFormFields(),
                        const SizedBox(height: AppDimensions.spaceM),
                        _buildAgreeRow(),
                        const SizedBox(height: AppDimensions.spaceXL),
                        _buildRegisterButton(),
                        const SizedBox(height: 40),
                        _buildDivider(),
                        const SizedBox(height: AppDimensions.spaceM),
                        _buildSocialButtons(),
                        const SizedBox(height: AppDimensions.spaceXXL),
                        _buildLogInLink(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
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
        color: AppColors.backgroundColor,
        size: AppDimensions.backIconSize,
      ),
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        AppStrings.register,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomInputField(
            width: screenWidth * 0.9,
            controller: _emailController,
            title: AppStrings.email,
            focusedBorderColor: Color(0xFF2454F8),
            keyboardType: TextInputType.emailAddress,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomInputField(
            width: screenWidth * 0.9,
            controller: _usernameController,
            title: AppStrings.username,
            focusedBorderColor: Color(0xFF2454F8),
            validator: Validators.validateUsername,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputField(
                controller: _firstnameController,
                title: AppStrings.firstName,
                focusedBorderColor: Color(0xFF2454F8),
                width: screenWidth * 0.52,
                validator: Validators.validateFirstName,
              ),
              const SizedBox(width: AppDimensions.spaceM),
              CustomInputField(
                controller: _lastnameController,
                title: AppStrings.lastName,
                focusedBorderColor: Color(0xFF2454F8),
                width: screenWidth * 0.33,
                validator: Validators.validateLastName,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          CustomInputField(
            width: screenWidth * 0.9,
            focusedBorderColor: Color(0xFF2454F8),
            controller: _passwordController,
            title: AppStrings.password,
            obscureText: !_isPasswordVisible,
            validator: Validators.validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            onChanged: (value) {
              // Real-time validation if needed
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAgreeRow() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: screenWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: _agree,
              onChanged: (v) => setState(() => _agree = v ?? false),
              activeColor: AppColors.primaryAppColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(text: 'Tôi đồng ý với '),
                    TextSpan(
                      text: 'Chính sách',
                      style: const TextStyle(color: Color(0xFF0D5BFF)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: mở link chính sách
                        },
                    ),
                    const TextSpan(text: ' và '),
                    TextSpan(
                      text: 'Điều khoản sử dụng',
                      style: const TextStyle(color: Color(0xFF0D5BFF)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: mở link điều khoản
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton() => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      final isLoading = state is AuthLoading;

      return AuthCustomButton(
        text: isLoading ? 'Đang đăng ký...' : AppStrings.register,
        onPressed: isLoading ? null : _handleRegister,
        isLoading: isLoading,
      );
    },
  );

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.primaryAppColor)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.spaceS),
          child: Text(
            AppStrings.orRegisterWith,
            style: TextStyle(color: AppColors.primaryAppColor, fontSize: 16),
          ),
        ),
        Expanded(child: Divider(color: AppColors.primaryAppColor)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonGgFbAuth(
          onPressed: _handleGoogleRegister,
          image: Image(image: AssetImage('assets/images/google_icon.png')),
          text: 'Google',
          width: screenWidth * 0.4,
        ),
        ButtonGgFbAuth(
          onPressed: _handleFacebookRegister,
          image: Image(image: AssetImage('assets/images/facebook_icon.png')),
          text: 'Facebook',
          width: screenWidth * 0.4,
        ),
      ],
    );
  }

  Widget _buildLogInLink() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        child: const Text.rich(
          TextSpan(
            text: 'Đã có tài khoản? ',
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: AppStrings.login,
                style: TextStyle(
                  color: AppColors.primaryAppColor,
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

  // Hàm _handleRegister đã được sửa
  void _handleRegister() {
    // 1. Kiểm tra form
    if (!_formKey.currentState!.validate()) return;

    // 2. Kiểm tra đã đồng ý điều khoản chưa
    if (!_agree) {
      _showSnackBar(
        'Vui lòng đồng ý với các điều khoản và chính sách',
        isError: true,
      );
      return;
    }

    // 3. Ẩn bàn phím
    FocusScope.of(context).unfocus();

    // 4. Gửi sự kiện tới AuthBloc
    context.read<AuthBloc>().add(
      RegisterRequested(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
        firstName: _firstnameController.text.trim(),
        lastName: _lastnameController.text.trim(),
        email: _emailController.text.trim(),
      ),
    );
  }

  void _handleGoogleRegister() {
    _showSnackBar('Chức năng đăng ký bằng Google đang được phát triển');
  }

  void _handleFacebookRegister() {
    _showSnackBar('Chức năng đăng ký bằng Facebook đang được phát triển');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }
}
