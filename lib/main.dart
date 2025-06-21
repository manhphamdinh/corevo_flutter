import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/forgotpassword_screen.dart';
import 'package:flutter_application_1/screens/register_demo.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'screens/login_screen.dart'; // Import file LoginScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false, // Ẩn banner debug
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Roboto', // Font chữ
      ),
      home: RegisterDemo(), // Màn hình chíh
    );
  }
}
