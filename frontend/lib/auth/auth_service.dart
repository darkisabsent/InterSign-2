import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{
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

    response = await http.post(Uri.parse(baseURL),
        headers: {
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "role_id": roleID ?? 3,
        }));

    if (response.statusCode == 200) {
      log("Register: ${response.body.toString()}");
      return true;
    } else if (response.statusCode == 422) {
      // Parse the message from the response body
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String errorMessage = data['message'];

      log("Error: $errorMessage");

      return false;
    } else {
      log("Register: ${response.statusCode.toString()}");
      log("Register: ${response.body.toString()}");

      return false;
    }
  }

  Future<bool> logout() async {
    const baseURL = 'http://127.0.0.1:8000/api/logout';
    late http.Response response;

    // Retrieve the authentication token
    String? token = await _storage.read(key: 'auth_token');
    if (token == null) {
      log('No auth token found, cannot log out.');
      return false;
    }

    try {
      response = await http.post(Uri.parse(baseURL), headers: {
        "Content-Type": "application/json",
        "Cache-Control": "no-cache",
        "Authorization": "Bearer $token", // Include the token in the header
      });

      if (response.statusCode == 200) {
        // Logout successful
        await _storage.delete(
            key: 'auth_token');
        notifyListeners();  // Notify listeners about the change

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

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }
}

/// Making authenticated requests
/* final token = await auth.getAuthToken();
response = await http.post(Uri.parse(baseURL),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      "Cache-Control": "no-cache",
    },
    body: jsonEncode({"email": email, "password": password}));
    */
