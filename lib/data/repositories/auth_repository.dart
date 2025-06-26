import 'package:flutter_application_1/core/constants/app_string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/register_request.dart';
import '../models/register_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/v1/auth';

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 201) {
        return RegisterResponse(success: true);
      } else {
        final errorData = jsonDecode(response.body);
        return RegisterResponse(
          success: false,
          message: errorData['message'] ?? AppStrings.registerFailed,
        );
      }
    } catch (e) {
      return RegisterResponse(success: false, message: AppStrings.generalError);
    }
  }

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json', 'Accept': '*/*'},
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return LoginResponse(
          success: true,
          token: responseData['token'],
          user: responseData['user'],
          message: responseData['message'],
        );
      } else {
        final errorData = jsonDecode(response.body);
        return LoginResponse(
          success: false,
          message: errorData['message'] ?? AppStrings.loginFailed,
        );
      }
    } catch (e) {
      return LoginResponse(success: false, message: AppStrings.generalError);
    }
  }
}
