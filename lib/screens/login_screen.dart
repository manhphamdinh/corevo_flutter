import 'package:flutter/material.dart';
import 'register_screen.dart'; // Import file LoginScreen
import 'forgotpassword_screen.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền - chỉ hiện ở nửa màn hình
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height:
                MediaQuery.of(context).size.height *
                0.5, // 50% chiều cao màn hình
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          // ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color.fromARGB(255, 24, 12, 51),
                    Color.fromARGB(255, 24, 12, 51),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      SizedBox(height: 45),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      // Title
                      SizedBox(height: 165),
                      Center(
                        child: Text(
                          'Đăng Nhập',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Form fields
                      SizedBox(height: 60),
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Số điện thoại hoặc email',
                        prefixIcon: Icons.email_outlined,
                        focusNode: _emailFocusNode,
                      ),

                      SizedBox(height: 25),
                      _buildTextField(
                        controller: _passwordController,
                        hintText: 'Mật khẩu',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        focusNode: _passwordFocusNode,
                      ),

                      // Forgot password
                      // Forgot password - Phiên bản gọn
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      // Login button
                      SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFc62f82), Color(0xFF7c27a2)],
                          ),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _handleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Divider
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white30)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Hoặc đăng nhập bằng',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white30)),
                        ],
                      ),

                      // Social login buttons
                      SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            onTap: () => _handleGoogleLogin(),
                            child: Container(
                              width: 48, // Đảm bảo kích thước hình vuông
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              clipBehavior: Clip
                                  .antiAlias, // Quan trọng để cắt ảnh theo hình tròn
                              child: Image.asset(
                                'assets/images/google_icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 27),
                          _buildSocialButton(
                            onTap: () => _handleFacebookLogin(),
                            child: Container(
                              width: 48, // Đảm bảo kích thước hình vuông
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              clipBehavior: Clip
                                  .antiAlias, // Quan trọng để cắt ảnh theo hình tròn
                              child: Image.asset(
                                'assets/images/facebook_icon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Register link
                      SizedBox(height: 27),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Chưa có tài khoản? ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Đăng ký',
                                  style: TextStyle(
                                    color: Color(0xFFc62f82),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    FocusNode? focusNode,
  }) {
    return StatefulBuilder(
      builder: (context, setTextFieldState) {
        bool isFocused = focusNode?.hasFocus ?? false;
        bool hasText = controller.text.isNotEmpty;

        // Listen to focus changes
        focusNode?.addListener(() {
          setTextFieldState(() {
            isFocused = focusNode?.hasFocus ?? false;
          });
        });

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: (isFocused || hasText)
                  ? [Color(0xFFc62f82), Color(0xFF7c27a2)]
                  : [Colors.transparent, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.all(2), // giữ border luôn dày 2
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2a2a4a),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: isPassword ? _obscurePassword : false,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setTextFieldState(() {});
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(prefixIcon, color: Colors.white54),
                suffixIcon: isPassword
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white54,
                        ),
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final url = Uri.parse(
      'http://10.0.2.2:8080/api/v1/auth/login',
    ); // Đảm bảo dùng đúng IP với emulator

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode({'emailOrUsername': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // TODO: Tùy backend, bạn cần lấy token từ body hoặc header
        // final token = jsonDecode(response.body)['token'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng nhập thành công'),
            backgroundColor: Colors.green,
          ),
        );

        // TODO: Chuyển đến trang chính của app
        // Navigator.pushReplacement(...);
      }
    } catch (e) {
      _showErrorDialog('');
    }
  }

  void _handleGoogleLogin() {
    // TODO: Implement Google login
    print('Google login pressed');
  }

  void _handleFacebookLogin() {
    // TODO: Implement Facebook login
    print('Facebook login pressed');
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF2C2C2C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Center(
            child: Text(
              "Thông báo",
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 58, 160),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          content: Text(
            'Thông tin đăng nhập không chính xác',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          actions: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFc62f82), Color(0xFF7c27a2)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Thử lại',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
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
