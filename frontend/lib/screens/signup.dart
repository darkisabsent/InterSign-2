import 'dart:io';
import 'package:flutter/material.dart';

import '../utils/show_toast.dart';
import '../widgets/form_container.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool passwordsMatch = true;
  bool _isSigningUp = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordsMatch);
    _confirmPasswordController.addListener(_checkPasswordsMatch);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Inter Sign"),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sign Up",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        FormContainerWidget(
                          hintText: "Full Name",
                          isPasswordField: false,
                          controller: _fullNameController,
                        ),
                        //const SizedBox(height: 7),
                        FormContainerWidget(
                          hintText: "Email",
                          isPasswordField: false,
                          controller: _emailController,
                        ),
                        //const SizedBox(height: 7),
                        FormContainerWidget(
                          hintText: "Password",
                          isPasswordField: true,
                          controller: _passwordController,
                        ),
                        Visibility(
                          visible: !passwordsMatch,
                          child: const Text("Passwords do no match!",
                              style: TextStyle(
                                  color: Colors.red,
                                  //color: errorRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ),
                        FormContainerWidget(
                          hintText: "Confirm Password",
                          isPasswordField: true,
                          controller: _confirmPasswordController,
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              _signUp();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "CREATE AN ACCOUNT",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                    (route) => false);
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_isSigningUp)
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

  Future<void> _signUp() async {
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Show loading circle
    setState(() {
      _isSigningUp = true;
    });
  }

  void _checkPasswordsMatch() {
    setState(() {
      passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
    });
  }
}
