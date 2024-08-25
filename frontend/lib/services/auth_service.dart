import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  Future<bool> login({required String email, required String password}) async {
    const baseURL = 'http://127.0.0.1:8000/api/login';
    late http.Response response;

    try {
      response = await http.post(Uri.parse(baseURL),
          headers: {
            "Content-Type": "application/json",
            "Cache-Control": "no-cache",
          },
          body: jsonEncode({"email": email, "password": password}));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['success']) {
          final String token = data['data']['access_token'];

          await _storage.write(key: 'auth_token', value: token);
          log("Auth token: $token");

          log("Login: ${response.body.toString()}");
          return true;
        } else {
          log("Login failed: ${data['message']}");
          return false;
        }
      } else {
        log("Login: ${response.statusCode.toString()}");

        return false;
      }
    } catch (e) {
      log("Login error: $e");
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    int? roleID,
  }) async {
    const baseURL = 'http://127.0.0.1:8000/api/register';
    late http.Response response;

    try {
      response = await http.post(
        Uri.parse(baseURL),
        headers: {
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "role_id": roleID ?? 3,
        }),
      );

      // Handle HTTP redirects
      if (response.statusCode == 302) {
        log("Redirect detected. Status code: 302");
        return false;
      }

      // Handle successful response
      if (response.statusCode == 200) {
        log("Register: ${response.body.toString()}");
        return true;
      }

      // Handle validation errors
      if (response.statusCode == 422) {
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final String errorMessage = data['message'];

          log("Error: $errorMessage");
          return false;
        } catch (e) {
          log("Error parsing error response: $e");
          return false;
        }
      }

      // Handle other errors
      log("Register: ${response.statusCode.toString()}");
      log("Register: ${response.body.toString()}");
      return false;
    } catch (e) {
      log("Register error: $e");
      return false;
    }
  }

  Future<bool> logout() async {
    const baseURL = 'http://127.0.0.1:8000/api/logout';
    late http.Response response;

    String? token = await _storage.read(key: 'auth_token');
    if (token == null) {
      log('No auth token found, cannot log out.');
      return false;
    }

    try {
      response = await http.post(Uri.parse(baseURL), headers: {
        "Content-Type": "application/json",
        "Cache-Control": "no-cache",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        // Logout successful
        await _storage.delete(key: 'auth_token');
        notifyListeners();

        log("Logout: ${response.body.toString()}");
        return true;
      } else {
        log("Logout failed: ${response.statusCode.toString()}");
        return false;
      }
    } catch (e) {
      log("Logout error: $e");
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      // Check if auth_token exists in secure storage
      String? token = await _storage.read(key: 'auth_token');
      return token != null;
    } catch (e) {
      log('Error checking login status: $e');
      return false;
    }
  }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    const baseURL = 'http://127.0.0.1:8000/api/users/password_reset';
    late http.Response response;

    String? token = await _storage.read(key: 'auth_token');
    if (token == null) {
      log('No auth token found, cannot change password');
      return false;
    }

    try {
      response = await http.post(
        Uri.parse(baseURL),
        headers: {
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "confirm_old_password": oldPassword,
          "password": newPassword,
        }),
      );

      if (response.statusCode == 200) {
        log("Change password: ${response.body.toString()}");
        return true;
      } else if (response.statusCode == 401) {
        log("Change password failed: ${response.body.toString()}");
        return false;
      } else {
        log("Change password: ${response.statusCode.toString()}");
        log("Change password: ${response.body.toString()}");
        return false;
      }
    } catch (e) {
      log("Change password error: $e");
      return false;
    }
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }
}
