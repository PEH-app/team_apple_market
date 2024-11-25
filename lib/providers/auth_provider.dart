import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final String _baseUrl = '';

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        _user = UserModel.fromJson(jsonDecode(response.body));
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = jsonDecode(response.body)['message'] ?? 'Login failed.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        _user = UserModel.fromJson(jsonDecode(response.body));
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage =
            jsonDecode(response.body)['message'] ?? 'Registration failed.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
