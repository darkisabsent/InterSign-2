import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> login({required String email, required String password}) async {
    const baseURL = 'http://127.0.0.1:8000/api/login';
    late http.Response response;

    response = await http.post(Uri.parse(baseURL),
        headers: {
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
        },
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      log("Login: ${response.body.toString()}");
      return true;
    } else {
      log("Login: ${response.statusCode.toString()}");

      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
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
        }));

    if (response.statusCode == 200) {
      log("Register: ${response.body.toString()}");
      return true;
    } else {
      log("Register: ${response.statusCode.toString()}");
      log("Register: ${response.body.toString()}");

      return false;
    }
  }

  Future<String> logout(String text,
      {String? currentLanguage, String? localLanguage}) async {
    const baseURL = 'http://127.0.0.1:8000/api/logout';
    late http.Response response;

    response = await http.post(Uri.parse(baseURL),
        headers: {
          "Content-Type": "application/json",
          "Cache-Control": "no-cache",
        },
        body: jsonEncode({"in": text, "lang": "en-$localLanguage"}));

    if (response.statusCode == 200) {
      // Ensure the response body is decoded as UTF-8
      String result = utf8.decode(response.bodyBytes);

      // Remove the first and last quotation marks if they exist
      if (result.startsWith('"') && result.endsWith('"')) {
        result = result.substring(1, result.length - 1);
      }

      return result;
    } else {
      return response.statusCode.toString();
    }
  }
}
