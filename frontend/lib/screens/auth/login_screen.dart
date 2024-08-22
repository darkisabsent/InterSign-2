import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inter_sign/screens/auth/recover_password_screen.dart';
import 'package:inter_sign/screens/primary/dashboard.dart';
import 'package:inter_sign/widgets/info_card.dart';
import 'package:inter_sign/widgets/logo_widget.dart';

import '../../auth/auth_service.dart';
import '../../utils/responsive.dart';
import '../../utils/show_toast.dart';
import '../../widgets/form_container.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final auth = AuthService();
  bool _isSigningIn = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _areFieldsFilled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isDesktop = Responsive.isDesktop(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive button size
    double buttonWidth = screenWidth * 0.8;
    double buttonHeight = screenHeight * 0.07;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SafeArea(
              child: Row(
                children: [
                  /// Left section
                  Expanded(
                    flex: isDesktop
                        ? 6
                        : isTablet
                            ? 5
                            : 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: isDesktop
                              ? screenWidth * 0.45
                              : isTablet
                                  ? screenWidth * 0.4
                                  : screenWidth * 0.35,
                          height: isDesktop
                              ? screenHeight * 0.85
                              : isTablet
                                  ? screenHeight * 0.75
                                  : screenHeight * 0.65,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(4.0), // Rounded corners
                            ),
                            child: Column(
                              children: [
                                /// Logo
                                const LogoWidget(),

                                /// Text
                                Flexible(
                                  child: Text(
                                    "Login",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),

                                /// Form
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 30, right: 30),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      FormContainerWidget(
                                        labelText: "EMAIL ADDRESS",
                                        hintText: "johndoe@example.com",
                                        isPasswordField: false,
                                        controller: _emailController,
                                        onChanged: (value) => setState(() {}),
                                      ),
                                      const SizedBox(height: 10),
                                      FormContainerWidget(
                                        labelText: "PASSWORD",
                                        hintText: "********",
                                        isPasswordField: true,
                                        controller: _passwordController,
                                        onChanged: (value) => setState(() {}),
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: _rememberMe,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _rememberMe = value ?? false;
                                              });
                                            },
                                          ),
                                          const Text(
                                            "Remember Me",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RecoverPasswordScreen(),
                                                  ),
                                                  (route) => false);
                                            },
                                            child: Text(
                                              "Forgot Password?",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.blueGrey[700],
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                /// Buttons
                                Center(
                                  child: SizedBox(
                                    width: buttonWidth * 0.48,
                                    height: buttonHeight * 1.2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_areFieldsFilled()) {
                                            _signIn();
                                          }

                                          ToastUtil.showErrorToast(context,
                                              message:
                                                  "Provide email and password!");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _areFieldsFilled()
                                              ? Colors.black
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "LOGIN",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Flexible(
                                      child: Text(
                                        "Don't have an account?",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignupScreen(),
                                              ),
                                              (route) => false);
                                        },
                                        child: Text(
                                          "SIGN UP",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Right section
                  if (!isMobile)
                    Expanded(
                      flex: isDesktop ? 6 : 5,
                      child: const InfoCard(),
                    ),
                ],
              ),
            ),
            if (_isSigningIn)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Show loading circle
    setState(() {
      _isSigningIn = true;
    });

    bool isAuthenticated = await auth.login(email: email, password: password);

    if (isAuthenticated) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
            (route) => false);
      }
    }

    // Pop loading circle
    setState(() {
      _isSigningIn = false;
    });

    if (mounted) {
      ToastUtil.showErrorToast(context,
          message: "Incorrect email or password!");
    }
  }
}
