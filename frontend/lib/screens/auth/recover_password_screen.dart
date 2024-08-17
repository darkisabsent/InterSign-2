import 'package:flutter/material.dart';
import 'package:inter_sign/screens/right_section.dart';

import '../../utils/responsive.dart';
import '../../widgets/form_container.dart';
import 'login_screen.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
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
                                    "Recover Password",
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
                                      ),
                                      const SizedBox(height: 10),

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
                                        child: const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "SUBMIT",
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
                                        "Have an account?",
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
                                                const LoginScreen(),
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
                      child: const RightSection(),
                    ),
                ],
              ),
            ),
            if (_isSubmitting)
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

  Future<void> _recoverPassword() async {
    String email = _emailController.text;

    // Show loading circle
    setState(() {
      _isSubmitting = true;
    });
  }
}
