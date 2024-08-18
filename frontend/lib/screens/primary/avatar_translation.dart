import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import 'package:video_player_win/video_player_win.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';
// import 'package:bitsdojo_window/bitsdojo_window.dart';

class AvatarTranslation extends StatefulWidget {
  const AvatarTranslation({super.key});

  @override
  State<AvatarTranslation> createState() => _AvatarTranslationState();
}

class _AvatarTranslationState extends State<AvatarTranslation>
    with WidgetsBindingObserver {
  late double initialWidth;
  late double initialHeight;
  bool _isMiniMode = false;
  WinVideoPlayerController? _controller;
  List<String> _videoUrls = [];
  int _currentVideoIndex = 0;
  String _text = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getInitialDimensions();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller?.play();
    }
  }

  Future<void> _getInitialDimensions() async {
    // Fetch the initial screen dimensions
    final screenSize = await windowManager.getBounds();

    setState(() {
      initialWidth = screenSize.width;
      initialHeight = screenSize.height;
    });
  }

  void _toggleMiniMode() async {
    setState(() {
      _isMiniMode = !_isMiniMode;
    });

    if (_isMiniMode) {
      // Set window to always on top
      await windowManager.setAlwaysOnTop(true);

      // Get the current window size
      Size windowSize = await windowManager.getSize();
      double currentWidth = windowSize.width;
      double currentHeight = windowSize.height;

      // Calculate 40% of screen width and 30% of screen height
      double windowWidth = currentWidth * 0.40;
      double windowHeight = currentHeight * 0.30;

      // Set the window size to 40% width and 30% height
      await windowManager.setSize(Size(windowWidth, windowHeight));

      // Set the position to top-right
      double x = currentWidth - windowWidth;
      double y = 0; // Top position

      // Set the window position to the top-right corner
      await windowManager.setPosition(Offset(x, y));
      // Play the video when in mini mode
      _controller?.play();
    } else {
      // Unset window to always on top
      await windowManager.setAlwaysOnTop(false);

      // Reset the window to the initial dimensions
      await windowManager.setSize(Size(initialWidth, initialHeight));

      // Center the window on the screen
      await windowManager.center();

      // Pause the video when not in mini mode
      _controller?.pause();
    }
  }

  void _initializeVideoPlayer(String url) {
    if (kDebugMode) {
      print('Initializing video player with URL: $url');
    }
    _controller = WinVideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _controller?.play();
        });
        _controller?.addListener(_videoListener);
      }).catchError((error) {
        if (kDebugMode) {
          print('Error initializing video: $error');
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error playing video: ${error.message}')),
          );
        });
      });
  }

  void _videoListener() {
    if (_controller?.value.position == _controller?.value.duration) {
      _playNextVideo();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_text.isEmpty) {
      log('No text to send.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/translate_text'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': _text}),
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        log('Response body: $responseBody');
        final videoUrls = (jsonDecode(responseBody)['video'] as List)
            .map((url) => 'http://localhost:8000/$url')
            .toList();
        setState(() {
          _videoUrls = videoUrls;
          _currentVideoIndex = 0;
          if (kDebugMode) {
            print('Video URLs received: $_videoUrls');
          }
        });
        _playNextVideo();
      } else {
        if (kDebugMode) {
          print(
              'Failed to load video URLs. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error occurred during HTTP request: $e');
      }
      if (kDebugMode) {
        print('Stack trace: $stackTrace');
      }
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred during HTTP request: $e')),
        );
      });
    }
  }

  void _playNextVideo() {
    if (_currentVideoIndex < _videoUrls.length) {
      final videoUrl = _videoUrls[_currentVideoIndex];
      if (kDebugMode) {
        print('Playing video: $videoUrl');
      }
      _initializeVideoPlayer(videoUrl);
      _currentVideoIndex++;
    }
  }

  void _startRecording() async {
    // Start the Python script to record audio and convert to text
    Process.run('python', ['../backend/audio_capture.py']).then((result) {
     log(result.stdout);
      log(result.stderr);

      // Extract the transcribed text from the stdout
      final transcribedText = _extractTranscribedText(result.stdout);
      if (transcribedText != null) {
        setState(() {
          _text = transcribedText;
        });
      }
    });
  }

  String? _extractTranscribedText(String stdout) {
    final regex = RegExp(r'Transcribed Text: (.+)');
    final match = regex.firstMatch(stdout);
    return match?.group(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isMiniMode
          ? null
          : AppBar(
              title: const Text('Avatar Translation'),
        centerTitle: true,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMiniMode,
        child: const Icon(Icons.layers),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Added SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_controller != null && _controller!.value.isInitialized)
                Transform.translate(
                  offset:
                      _isMiniMode ? const Offset(0, -50) : const Offset(0, 0),
                  // Move video up by 50 pixels in mini mode
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: WinVideoPlayer(_controller!),
                  ),
                ),
              if (!_isMiniMode) ...[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: TextEditingController(text: _text),
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter text',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: _startRecording,
                  child: const Text('Start Recording'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
