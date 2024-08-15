import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String? selectedImagePath;
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
          /*gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).colorScheme.secondary,
          Colors.white,
        ],
      ),*/
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
                  CircleAvatar(
                    radius: 68,
                    backgroundColor: Colors.black,
                    child: Stack(
                      children: [
                        selectedImagePath != null
                            ? CircleAvatar(
                                radius: 66,
                                backgroundImage:
                                    FileImage(File(selectedImagePath!)),
                              )
                            : const CircleAvatar(
                                radius: 80,
                                backgroundImage: AssetImage(
                                    'assets/images/no_profile.png'),
                              ),
                        Positioned(
                          bottom: -5,
                          left: 85,
                          child: IconButton(
                            onPressed: () {
                              showImagePickerOption(context);
                            },
                            icon: const Icon(Icons.add_a_photo,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Create An Account",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        /*const Text("Upload an image and fill the spaces below",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 14,
                            )),*/
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
                              if (selectedImagePath != null) {
                                _signUp();
                              } else {
                                _promptAddPhoto();
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: BoxDecoration(
                                color: selectedImagePath != null
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "SIGN UP",
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

  void _promptAddPhoto() {
    ToastUtil.showSuccessToast(context,
        message: 'Please add a photo for profile.');
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImagePath = returnImage.path;
    });
    if (kDebugMode) print(selectedImagePath);
    if (mounted) {
      Navigator.of(context).pop(); //close the model sheet
    }
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImagePath = returnImage.path;
    });
    if (kDebugMode) print(selectedImagePath);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void showImagePickerOption(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Add image from:'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('Gallery'),
                      onTap: _pickImageFromGallery,
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Take Photo'),
                      onTap: _pickImageFromCamera,
                    )
                  ],
                ),
              ));
        });
  }
}
