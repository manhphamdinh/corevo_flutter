import 'package:flutter/material.dart';
import '../models/register_request.dart';
import '../services/auth_service.dart';

class RegisterDemo extends StatefulWidget {
  const RegisterDemo({Key? key}) : super(key: key);

  @override
  State<RegisterDemo> createState() => _RegisterDemoState();
}

class _RegisterDemoState extends State<RegisterDemo> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();

  final AuthService _authService = AuthService();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final request = RegisterRequest(
        username: _username.text,
        password: _password.text,
        firstName: _firstName.text,
        lastName: _lastName.text,
        email: _email.text,
      );

      final success = await _authService.register(request);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'Đăng ký thành công!' : 'Đăng ký thất bại'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng ký tài khoản")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _username,
                decoration: InputDecoration(labelText: 'Tên đăng nhập'),
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
              ),
              TextFormField(
                controller: _firstName,
                decoration: InputDecoration(labelText: 'Họ tên đệm'),
              ),
              TextFormField(
                controller: _lastName,
                decoration: InputDecoration(labelText: 'Tên'),
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _register, child: Text("Đăng ký")),
            ],
          ),
        ),
      ),
    );
  }
}
