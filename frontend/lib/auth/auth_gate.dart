import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inter_sign/screens/auth/login_screen.dart';
import 'package:inter_sign/screens/primary/dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  final _storage = const FlutterSecureStorage();


  Future<bool> _isUserLoggedIn() async {
    // Check if authToken exists in secure storage
    String? token = await _storage.read(key: 'authToken');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isUserLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data == true) {
          return const Dashboard();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
