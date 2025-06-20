import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int selectedOption = 0; // 0 for Email, 1 for Phone
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
        255,
        24,
        12,
        51,
      ), // Dark purple background
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
            ),
            SizedBox(height: 23),

            // Title
            Text(
              'Quên mật khẩu',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
            ),

            SizedBox(height: 10),

            // Subtitle
            Text(
              'Nhập Email hoặc Số điện thoại của bạn để đặt lại mật khẩu',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontFamily: 'Roboto',
              ),
            ),

            SizedBox(height: 40),

            Center(
              child: Container(
                width: 250,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFc62f82), Color(0xFF7c27a2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Color(0xFF180C33), // Hộp 2: nền đen
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Email toggle
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 0;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            height: 36,
                            decoration: BoxDecoration(
                              color: selectedOption == 0
                                  ? Color(0xFFc62f82)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Phone toggle
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = 1;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            height: 36,
                            decoration: BoxDecoration(
                              color: selectedOption == 1
                                  ? Color(0xFFc62f82)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Số điện thoại',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 33),

            // Email input field
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2a2a4a),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildTextField(
                controller: emailController,
                hintText: selectedOption == 0
                    ? 'Nhập Email của bạn'
                    : 'Nhập số điện thoại của bạn',
                focusNode: emailFocusNode,
              ),
            ),

            SizedBox(height: 33),

            // Confirm button
            Center(
              child: Container(
                width: 160,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFc62f82), Color(0xFF7c27a2)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _handleForgotPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    FocusNode? focusNode,
  }) {
    return StatefulBuilder(
      builder: (context, setTextFieldState) {
        bool isFocused = focusNode?.hasFocus ?? false;
        bool hasText = controller.text.isNotEmpty;

        // Cập nhật trạng thái khi focus thay đổi
        focusNode?.addListener(() {
          setTextFieldState(() {
            isFocused = focusNode?.hasFocus ?? false;
          });
        });

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: (isFocused || hasText)
                ? LinearGradient(
                    colors: [Color(0xFFc62f82), Color(0xFF7c27a2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
          ),
          padding: EdgeInsets.all(2), // tạo viền 2px
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF2a2a4a), // Màu nền của TextField
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
              onChanged: (value) {
                setTextFieldState(() {}); // Cập nhật khi nhập text
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontFamily: 'Roboto',
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
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

  void _handleForgotPassword() {
    // Add your forgot password logic here
    String input = emailController.text.trim();

    if (input.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            selectedOption == 0
                ? 'Vui lòng nhập email'
                : 'Vui lòng nhập số điện thoại',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          selectedOption == 0
              ? 'Link đặt lại mật khẩu đã được gửi đến email của bạn'
              : 'Mã xác nhận đã được gửi đến số điện thoại của bạn',
          style: TextStyle(fontFamily: 'Roboto'),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
