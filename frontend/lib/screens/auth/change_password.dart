import 'package:flutter/material.dart';
import 'package:inter_sign/widgets/info_card.dart';
import 'package:inter_sign/widgets/logo_widget.dart';

import '../../services/auth_service.dart';
import '../../utils/responsive.dart';
import '../../utils/show_toast.dart';
import '../../widgets/form_container.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final auth = AuthService();
  bool _isSubmitting = false;
  bool passwordsMatch = true;

  @override
  void initState() {
    super.initState();
    _currentPassController.addListener(_checkPasswordsMatch);
    _confirmPassController.addListener(_checkPasswordsMatch);
  }

  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  bool _areFieldsFilled() {
    return _currentPassController.text.isNotEmpty &&
        _newPassController.text.isNotEmpty &&
        _confirmPassController.text.isNotEmpty;
  }

  void _checkPasswordsMatch() {
    setState(() {
      passwordsMatch = _newPassController.text == _confirmPassController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isDesktop = Responsive.isDesktop(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 0.8;
    double buttonHeight = screenHeight * 0.07;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(),
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
                                    "Change Password",
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
                                        labelText: "CURRENT PASSWORD",
                                        hintText: "********",
                                        isPasswordField: true,
                                        controller: _currentPassController,
                                        onChanged: (value) => setState(() {}),
                                      ),
                                      const SizedBox(height: 10),
                                      FormContainerWidget(
                                        labelText: "NEW PASSWORD",
                                        hintText: "********",
                                        isPasswordField: true,
                                        controller: _newPassController,
                                        onChanged: (value) => setState(() {}),
                                      ),
                                      const SizedBox(height: 10),
                                      Visibility(
                                        visible: !passwordsMatch,
                                        child: const Text(
                                            "Passwords do no match!",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                      FormContainerWidget(
                                        labelText: "CONFIRM PASSWORD",
                                        hintText: "********",
                                        isPasswordField: true,
                                        controller: _confirmPassController,
                                        onChanged: (value) => setState(() {}),
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
                                            _changePassword();
                                            //Navigator.of(context).pop();
                                          } else {
                                            if (mounted) {
                                              ToastUtil.showErrorToast(context,
                                                  message:
                                                      "Passwords not provided");
                                            }
                                          }
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

  Future<void> _changePassword() async {
    String oldPassword = _currentPassController.text;
    String newPassword = _newPassController.text;

    setState(() {
      _isSubmitting = true;
    });

    bool changed = await auth.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);

    if (mounted) {
      if (changed) {
        ToastUtil.showSuccessToast(context,
            message: "Password changed successfully");

        _currentPassController.clear();
        _newPassController.clear();
        _confirmPassController.clear();
      }

      setState(() {
        _isSubmitting = false;
      });

      if (!changed) {
        ToastUtil.showErrorToast(context, message: "Error!");
      }
    }
  }
}
