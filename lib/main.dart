import 'package:flutter/material.dart';
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
      home: LoginScreen(), // Màn hình chíh
    );
  }
}
