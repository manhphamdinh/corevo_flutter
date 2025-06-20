import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: Color.fromARGB(255, 24, 12, 51)),
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),

                      // Title
                      Center(
                        child: Text(
                          'Đăng Ký',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Form fields
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: _fullNameController,
                        hintText: 'Họ và tên',
                        prefixIcon: Icons.person_outlined,
                        focusNode: _fullNameFocusNode,
                      ),
                      SizedBox(height: 19),
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Số điện thoại hoặc email',
                        prefixIcon: Icons.email_outlined,
                        focusNode: _emailFocusNode,
                      ),

                      SizedBox(height: 19),
                      _buildTextField(
                        controller: _usernameController,
                        hintText: 'Tên người dùng',
                        prefixIcon: Icons.person_outlined,
                        focusNode: _usernameFocusNode,
                      ),

                      SizedBox(height: 19),
                      _buildTextField(
                        controller: _passwordController,
                        hintText: 'Mật khẩu',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        onTogglePassword: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        focusNode: _passwordFocusNode,
                      ),

                      SizedBox(height: 19),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Nhập lại mật khẩu',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        obscureText: _obscureConfirmPassword,
                        onTogglePassword: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        focusNode: _confirmPasswordFocusNode,
                      ),

                      SizedBox(height: 19),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'Bằng việc tiếp tục sử dụng Corevo, bạn đồng ý chấp nhận\n',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: 'Thoả thuận người dùng ',
                                style: TextStyle(color: Color(0xFFc62f82)),
                              ),
                              TextSpan(
                                text: 'và ',
                                style: TextStyle(color: Colors.white70),
                              ),
                              TextSpan(
                                text: 'chính sách bảo mật',
                                style: TextStyle(color: Color(0xFFc62f82)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Register button
                      SizedBox(height: 35),
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
                            _handleRegister();
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                      // Divider
                      SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            onTap: () => _handleGoogleRegister(),
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
                            onTap: () => _handleFacebookRegister(),
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
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Đã có tài khoản? ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Đăng nhập',
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
    bool obscureText = false,
    VoidCallback? onTogglePassword,
    FocusNode? focusNode,
  }) {
    return StatefulBuilder(
      builder: (context, setTextFieldState) {
        bool isFocused = focusNode?.hasFocus ?? false;
        bool hasText = controller.text.isNotEmpty;

        // Listen to focus changes
        focusNode?.removeListener(() {});
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
          padding: EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2a2a4a),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: isPassword ? obscureText : false,
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
                        onTap: onTogglePassword,
                        child: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
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

  void _handleRegister() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String email = _emailController.text.trim();
    String fullName = _fullNameController.text.trim();
    final nameParts = _splitFullName(fullName);
    final firstName = nameParts['firstName'] ?? '';
    final lastName = nameParts['lastName'] ?? '';

    if (username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      SnackBar(content: Text('Sai mật khẩu'), backgroundColor: Colors.red);
      return;
    }

    final url = Uri.parse('http://10.0.2.2:8080/api/v1/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode({
          "username": username,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng ký thành công, vui lòng đăng nhập'),
            backgroundColor: Colors.green,
          ),
        );

        // TODO: Quay lại màn hình đăng nhập hoặc chuyển trang
        // Navigator.pop(context);
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body);
        SnackBar(
          content: Text('Đăng ký thất bại'),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackBar(content: Text('Đăng ký thất bại'), backgroundColor: Colors.red);
    }
  }

  void _handleGoogleRegister() {
    // TODO: Implement Google register
    print('Google register pressed');
  }

  void _handleFacebookRegister() {
    // TODO: Implement Facebook register
    print('Facebook register pressed');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _fullNameController.dispose();
    _fullNameFocusNode.dispose();
    super.dispose();
  }
}

// TODO: Implement API calls for registration
// Future<bool> register(String email, String username, String password) async {
//   final url = Uri.parse("https://your-api.com/register");

//   final response = await http.post(
//     url,
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({
//       "email": email,
//       "username": username,
//       "password": password,
//     }),
//   );

//   if (response.statusCode == 201) {
//     return true;
//   } else {
//     return false;
//   }
// }
Map<String, String> _splitFullName(String fullName) {
  List<String> parts = fullName.trim().split(RegExp(r'\s+'));
  if (parts.length == 1) {
    return {'firstName': '', 'lastName': parts[0]};
  }
  String lastName = parts.last;
  String firstName = parts.sublist(0, parts.length - 1).join(' ');
  return {'firstName': firstName, 'lastName': lastName};
}
