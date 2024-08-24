import 'package:flutter/material.dart';
import 'package:inter_sign/const/constant.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/settings/edit_item.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  String gender = "man";

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
                    Image.asset(
                      "assets/images/no_profile.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      /// TODO: implementation
                      onPressed: () {},
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
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
