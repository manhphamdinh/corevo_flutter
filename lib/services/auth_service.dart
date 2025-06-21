import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register_request.dart';

class AuthService {
  final String baseUrl = 'http://192.168.1.157:8080'; // Đổi IP thật tại đây

  Future<bool> register(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/register');
    // create   ->> post
    // update -> put
    // read -> get

    // delete-> delete
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Đăng ký thành công');
      return true;
    } else {
      print('Đăng ký thất bại: ${response.statusCode}');
      print(response.body);
      return false;
    }
  }
}
