import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import 'package:video_player_win/video_player_win.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

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
  bool _isListening = false;
  Process? _recordingProcess;
  bool _isTranslating = false; // Flag to track translation in progress
  Timer? _debounce; // Timer for debounce mechanism
  bool _wasPlayingBeforeMiniMode = false;
  TextEditingController _textController = TextEditingController();
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
      _controller?.play();
    }
  }

  Future<void> _initializeVideoPlayer(String url) async {
    _controller = WinVideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
        _controller?.play();
        _controller?.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller?.value.position == _controller?.value.duration) {
      _controller?.removeListener(_videoListener);
      _playNextVideo();
    }
  }

  Future<void> _submitText() async {
    final inputText = _textController.text;
    print('$inputText');
    if (inputText.isNotEmpty) {
      await _translateText(inputText.toUpperCase());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    _recordingProcess?.kill();
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _playNextVideo() {
    if (_currentVideoIndex < _videoUrls.length) {
      final videoUrl = _videoUrls[_currentVideoIndex];
      print('Playing video: $videoUrl');
      _initializeVideoPlayer(videoUrl);
      _currentVideoIndex++;
    } else {
      print('No more videos to play.');
    }
  }

  void _startListening() async {
    setState(() {
      _isListening = true;
    });

    final scriptPath = path.canonicalize('../backend/audio_capture.py');
    print('Starting Python process for audio capture at path: $scriptPath');

    // Ensure any previous process is killed before starting a new one
    _recordingProcess?.kill();

    _recordingProcess = await Process.start('python', [scriptPath]);

    // Listen to stdout
    _recordingProcess?.stdout.transform(utf8.decoder).listen((data) {
      print('Received data from Python process: $data');
      final partialText = _extractPartialText(data);
      if (partialText != null && partialText.isNotEmpty) {
        print('$partialText');
        setState(() {
          _text = partialText.toUpperCase(); // Convert to uppercase
        });
        _translateText(partialText
            .toUpperCase()); // Automatically translate the received text
      } else {
        print('No partial text found in data.');
      }
    });
    _recordingProcess?.stderr.transform(utf8.decoder).listen((error) {
      print('Error from Python process: $error');
    });
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    print('Stopping Python process for audio capture...');
    _recordingProcess?.kill();
  }

  String? _extractPartialText(String data) {
    print('$data');

    // Use a regular expression to find the "partial" result
    final regex = RegExp(r'"partial" : "(.*?)"');
    final match = regex.firstMatch(data);

    if (match != null) {
      final partialText = match.group(1);
      print('Match found: $partialText');
      return partialText;
    } else {
      return data;
    }
  }

  Future<void> _translateText(String text) async {
    final url = Uri.parse('http://localhost:8000/translate_text');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final videoUrls = (responseBody['video'] as List)
          .map((item) => item as String)
          .toList();
      final transcribedText = responseBody['text'] ??
          ''; // Assuming the backend also returns the transcribed text

      setState(() {
        _videoUrls = videoUrls;
        _text =
            transcribedText; // Update the text with the transcribed text from the backend
        _currentVideoIndex = 0;
      });
      if (_videoUrls.isNotEmpty) {
        _initializeVideoPlayer(_videoUrls[_currentVideoIndex]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isMiniMode
          ? null
          : AppBar(
              title: Text('Avatar Translation'),
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
                  offset: _isMiniMode
                      ? Offset(0, -50)
                      : Offset(0, 0), // Move video up by 50 pixels in mini mode
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: WinVideoPlayer(_controller!),
                  ),
                ),
              if (!_isMiniMode) ...[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      children: _buildTextSpans(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    _text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter text to translate',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitText,
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  child:
                      Text(_isListening ? 'Stop Listening' : 'Start Listening'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    for (int i = 0; i < _text.length; i++) {
      spans.add(
        TextSpan(
          text: _text[i],
          style: TextStyle(
            color: i == _currentVideoIndex ? Colors.red : Colors.black,
            fontWeight:
                i == _currentVideoIndex ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }
    return spans;
  }
}
