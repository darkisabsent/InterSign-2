import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class TranslateToSpeech extends StatefulWidget {
  const TranslateToSpeech({super.key});

  @override
  _TranslateToSpeechState createState() => _TranslateToSpeechState();
}

class _TranslateToSpeechState extends State<TranslateToSpeech> {
  int _cameraIndex = 0;
  int _cameraId = -1;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _fetchCameras();
  }

  @override
  void dispose() {
    _disposeCurrentCamera();
    super.dispose();
  }

  Future<void> _fetchCameras() async {
    List<CameraDescription> cameras = <CameraDescription>[];
    try {
      cameras = await CameraPlatform.instance.availableCameras();
      if (cameras.isNotEmpty) {
        _cameraIndex = _cameraIndex % cameras.length;
      }
    } on PlatformException catch (e) {
      print('Failed to get cameras: ${e.code}: ${e.message}');
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _disposeCurrentCamera() async {
    if (_cameraId >= 0 && _initialized) {
      try {
        await CameraPlatform.instance.dispose(_cameraId);
        if (mounted) {
          setState(() {
            _initialized = false;
            _cameraId = -1;
          });
        }
      } on CameraException catch (e) {
        print('Failed to dispose camera: ${e.code}: ${e.description}');
      }
    }
  }

  Future<void> _startInferenceScript() async {
  // Define the path to the directory containing inference.py
  final scriptDirectory = 'c:/Users/selim/intersign/InterSign-2/';

  // Print the path for debugging purposes
  print("Path to inference.py: ${scriptDirectory}inference.py");

  try {
    // Start the Python script with GPU support
    final process = await Process.start('python', ['inference.py', '--use-gpu'],
        workingDirectory: scriptDirectory);

    // Listen to the script's stdout and stderr
    process.stdout.transform(utf8.decoder).listen((data) {
      print("stdout: $data");
    });
    process.stderr.transform(utf8.decoder).listen((data) {
      print("stderr: $data");
    });

    // Wait for the process to complete
    final exitCode = await process.exitCode;
    print("Inference script exited with code $exitCode");
  } catch (e) {
    print("Error starting inference script: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("TRANSLATE TO SPEECH"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_initialized) {
                  _startInferenceScript();
                }
              },
              child: const Text("Open Camera"),
            ),
            _initialized
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CameraPlatform.instance.buildPreview(_cameraId),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
