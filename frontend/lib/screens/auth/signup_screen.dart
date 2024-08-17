import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../utils/show_toast.dart';
import '../../utils/layout_utils.dart';
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
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isDesktop = Responsive.isDesktop(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate responsive button size
    double buttonWidth = screenWidth * 0.8; // 80% of screen width
    double buttonHeight = screenHeight * 0.07; // 7% of screen height

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //appBar: AppBar(backgroundColor: Colors.transparent),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Inter",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Image.asset(
                                      'assets/images/avatar_image.png',
                                      height: isMobile
                                          ? screenHeight * 0.05
                                          : screenHeight * 0.1,
                                      width: isMobile
                                          ? screenWidth * 0.02
                                          : screenWidth * 0.05,
                                    ),
                                    const SizedBox(width: 2),
                                    Flexible(
                                      child: Text(
                                        "Sign",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge,
                                      ),
                                    ),
                                  ],
                                ),

                                /// Text
                                Flexible(
                                  child: Text(
                                    "Sign Up",
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
                                        labelText: "FIRST NAME",
                                        hintText: "John",
                                        isPasswordField: false,
                                        controller: _fullNameController,
                                      ),
                                      FormContainerWidget(
                                        labelText: "EMAIL ADDRESS",
                                        hintText: "johndoe@example.com",
                                        isPasswordField: false,
                                        controller: _emailController,
                                      ),
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
                                                    fontSize: 13)),
                                      ),
                                      FormContainerWidget(
                                        labelText: "CONFIRM PASSWORD",
                                        hintText: "********",
                                        isPasswordField: true,
                                        controller: _confirmPasswordController,
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
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: _isSigningUp
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "SIGN UP",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                        "Already have an account?",
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
                                                    const Login(),
                                              ),
                                              (route) => false);
                                        },
                                        child: Text(
                                          "LOGIN",
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
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff735ff1),
                            Color(0xff625ff1),
                          ],
                        )),
                        child: Center(
                          child: SizedBox(
                            width: isDesktop
                                ? screenWidth * 0.40
                                : isTablet
                                    ? screenWidth * 0.35
                                    : screenWidth * 0.3,
                            height: isDesktop
                                ? screenHeight * 0.7
                                : isTablet
                                    ? screenHeight * 0.6
                                    : screenHeight * 0.5,
                            child: Card(
                              color: const Color(0xffaea2f7),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    24.0), // Rounded corners
                              ),
                              child: Stack(
                                children: [
                                  const Positioned(
                                    top: 30,
                                    left: 40,
                                    child: Text(
                                      '"I will be your\n personal\n interpreter\n today"',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    //left: 120,
                                    right: 0,
                                    bottom: 0,
                                    child: Image.asset(
                                      'assets/images/avatar_image.png',
                                      height: isMobile
                                          ? screenHeight * 0.4
                                          : screenHeight * 0.5,
                                      width: isMobile
                                          ? screenWidth * 0.2
                                          : screenWidth * 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
