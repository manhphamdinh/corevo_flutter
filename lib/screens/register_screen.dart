import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/validators.dart';
import 'package:flutter_application_1/presentation/blocs/register_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/presentation/widgets/auth_custom_button.dart';
import 'package:flutter_application_1/presentation/widgets/button_gg_fb_auth.dart';
import 'package:flutter_application_1/presentation/widgets/custom_input_field.dart';
import 'package:flutter_application_1/presentation/widgets/text_bottom_auth.dart';
import 'package:flutter_application_1/core/constants/app_string.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isChecked = false;

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (!_isChecked) {
        _showSnackBar(
          'Vui lòng đồng ý với các điều khoản và chính sách',
          isError: true,
        );
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        _showSnackBar('Mật khẩu xác nhận không khớp', isError: true);
        return;
      }

      // Hide keyboard
      FocusScope.of(context).unfocus();

      // Trigger register event
      context.read<AuthBloc>().add(
        RegisterRequested(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
        ),
      );
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Xác nhận mật khẩu là bắt buộc';
    }
    if (value != _passwordController.text) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showSnackBar(state.message ?? AppStrings.registerSuccess);

            // Navigate to login screen or home screen
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state is AuthFailure) {
            _showSnackBar(state.message, isError: true);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Header
                Container(
                  width: screenWidth,
                  height: 135,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2454F8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.register,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Form Content
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      // Email Field
                      CustomInputField(
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        width: screenWidth * 0.9,
                        height: 64,
                        controller: _emailController,
                        title: AppStrings.email,
                        borderRadius: 12,
                        borderColor: Colors.grey[400],
                        focusedBorderColor: Color(0xFF2454F8),
                        validator: Validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          // Real-time validation if needed
                        },
                      ),

                      const SizedBox(height: 24),

                      // Username Field
                      CustomInputField(
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        width: screenWidth * 0.9,
                        height: 64,
                        controller: _usernameController,
                        title: AppStrings.username,
                        borderRadius: 12,
                        borderColor: Colors.grey[400],
                        focusedBorderColor: Color(0xFF2454F8),
                        validator: Validators.validateUsername,
                        onChanged: (value) {
                          // Real-time validation if needed
                        },
                      ),

                      const SizedBox(height: 24),

                      // First Name and Last Name Row
                      Row(
                        children: [
                          Expanded(
                            flex: 55,
                            child: CustomInputField(
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              width: double.infinity,
                              height: 64,
                              controller: _firstNameController,
                              title: AppStrings.firstName,
                              borderRadius: 12,
                              borderColor: Colors.grey[400],
                              focusedBorderColor: Color(0xFF2454F8),
                              validator: Validators.validateFirstName,
                              onChanged: (value) {
                                // Real-time validation if needed
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 45,
                            child: CustomInputField(
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              width: double.infinity,
                              height: 64,
                              controller: _lastNameController,
                              title: AppStrings.lastName,
                              borderRadius: 12,
                              borderColor: Colors.grey[400],
                              focusedBorderColor: Color(0xFF2454F8),
                              validator: Validators.validateLastName,
                              onChanged: (value) {
                                // Real-time validation if needed
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Password Field
                      CustomInputField(
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        width: screenWidth * 0.9,
                        height: 64,
                        controller: _passwordController,
                        title: AppStrings.password,
                        borderRadius: 12,
                        borderColor: Colors.grey[400],
                        focusedBorderColor: Color(0xFF2454F8),
                        obscureText: !_isPasswordVisible,
                        validator: Validators.validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
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

                      const SizedBox(height: 24),

                      // Confirm Password Field
                      CustomInputField(
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        width: screenWidth * 0.9,
                        height: 64,
                        controller: _confirmPasswordController,
                        title: 'Xác nhận mật khẩu',
                        borderRadius: 12,
                        borderColor: Colors.grey[400],
                        focusedBorderColor: Color(0xFF2454F8),
                        obscureText: !_isConfirmPasswordVisible,
                        validator: _validateConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        onChanged: (value) {
                          // Real-time validation if needed
                        },
                      ),

                      const SizedBox(height: 24),

                      // Terms and Conditions Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isChecked = !_isChecked;
                              });
                            },
                            child: Container(
                              width: 18,
                              height: 18,
                              margin: EdgeInsets.only(top: 2),
                              child: _isChecked
                                  ? Icon(
                                      Icons.check_box,
                                      color: Color(0xFF2454F8),
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: Colors.grey[600],
                                    ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isChecked = !_isChecked;
                                });
                              },
                              child: Text(
                                AppStrings.agreeTerms,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Register Button
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;

                          return AuthCustomButton(
                            text: isLoading
                                ? 'Đang đăng ký...'
                                : AppStrings.register,
                            onPressed: isLoading ? null : _handleRegister,
                            isLoading: isLoading,
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Divider
                      DividerWithText(text: AppStrings.orRegisterWith),

                      const SizedBox(height: 24),

                      // Social Register Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonGgFbAuth(
                            image: Image(
                              image: AssetImage(
                                'assets/images/google_icon.png',
                              ),
                            ),
                            width: screenWidth * 0.4,
                            text: 'Google',
                            onPressed: () {
                              // Handle Google register
                              _handleSocialRegister('google');
                            },
                          ),
                          ButtonGgFbAuth(
                            image: Image(
                              image: AssetImage(
                                'assets/images/facebook_icon.png',
                              ),
                            ),
                            width: screenWidth * 0.4,
                            text: 'Facebook',
                            onPressed: () {
                              // Handle Facebook register
                              _handleSocialRegister('facebook');
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyHaveAccount,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              AppStrings.login,
                              style: TextStyle(
                                color: Color(0xFF2454F8),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSocialRegister(String provider) {
    // Implement social register logic here
    _showSnackBar('Chức năng đăng ký bằng $provider đang được phát triển');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
