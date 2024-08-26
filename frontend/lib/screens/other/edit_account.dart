import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:inter_sign/const/constant.dart';

import '../../widgets/settings/edit_item.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "man";
  String? selectedImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_image.png';

    if (await File(imagePath).exists()) {
      setState(() {
        selectedImagePath = imagePath;
      });
    }
  }

  Future<void> _updateProfileImage(String newPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final savedImagePath = '${directory.path}/profile_image.png';

    await File(newPath).copy(savedImagePath);

    setState(() {
      selectedImagePath = savedImagePath;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    selectedImagePath != null
                        ? Image.file(
                      File(selectedImagePath!),
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    )
                        : Image.asset(
                      "assets/images/no_profile.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showImagePickerOption(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: purpleColor),
                      child: const Text(
                        "Update Image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const EditItem(
                title: "Name",
                widget: TextField(),
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Email",
              ),
              const SizedBox(height: 40,),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedImagePath != null) {
                      _updateProfileImage(selectedImagePath!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImagePath = returnImage.path;
    });
    log("Image path $selectedImagePath");
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImagePath = returnImage.path;
    });
    log("Image path $selectedImagePath");
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
