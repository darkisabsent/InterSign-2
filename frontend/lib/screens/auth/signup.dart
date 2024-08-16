import 'package:flutter/material.dart';

import '../../utils/show_toast.dart';
import '../../widgets/form_container.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: AppBar(backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            Row(
              children: [
                /// Left section
                SizedBox(
                  width: screenWidth / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Card(
                      color: Theme.of(context).cardColor,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(6.0), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            /// Logo
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Inter",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(width: 5),
                                Image.asset(
                                  'assets/images/avatar_image.png',
                                  height: 50,
                                  width: 50,
                                ),
                                const SizedBox(width: 5), // Optional spacing
                                Text(
                                  "Sign",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                              ],
                            ),

                            /// Text
                            Column(
                              children: [
                                Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),

                            /// Form
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// Text fields
                                Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    FormContainerWidget(
                                      labelText: "FIRST NAME",
                                      hintText: "John",
                                      isPasswordField: false,
                                      controller: _fullNameController,
                                    ),
                                    //const SizedBox(height: 7),
                                    FormContainerWidget(
                                      labelText: "EMAIL ADDRESS",
                                      hintText: "johndoe@example.com",
                                      isPasswordField: false,
                                      controller: _emailController,
                                    ),
                                    //const SizedBox(height: 7),
                                    FormContainerWidget(
                                      labelText: "PASSWORD",
                                      hintText: "********",
                                      isPasswordField: true,
                                      controller: _passwordController,
                                    ),
                                    Visibility(
                                      visible: !passwordsMatch,
                                      child:
                                          const Text("Passwords do no match!",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  //color: errorRed,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                    ),
                                    FormContainerWidget(
                                      labelText: "CONFIRM PASSWORD",
                                      hintText: "********",
                                      isPasswordField: true,
                                      controller: _confirmPasswordController,
                                    ),
                                  ],
                                ),

                                /// Buttons and other
                                Column(
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "CREATE AN ACCOUNT",
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login(),
                                                ),
                                                (route) => false);
                                          },
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// Right section
                Container(
                  width: screenWidth / 2,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff735ff1),
                      Color(0xff625ff1),
                    ],
                  )),
                  //color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Other Section',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
