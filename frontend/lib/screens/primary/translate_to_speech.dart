import 'package:flutter/material.dart';
import 'package:inter_sign/widgets/camera_widget.dart';

class TranslateToSpeech extends StatelessWidget {
  const TranslateToSpeech({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CameraScreen()),
          );
        },
        child: const Text("Record Video"),
      ),
      body: const Center(
        child: Text("TRANSLATE TO SPEECH"),
      ),
    );
  }
}
