import 'package:flutter/material.dart';
import 'package:inter_sign/screens/primary/video_recorder.dart';

class TranslateToSpeech extends StatelessWidget {
  const TranslateToSpeech({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VideoRecorder()),
          );
        },
        child: const Text("Record Video"),
      )),
    );
  }
}
