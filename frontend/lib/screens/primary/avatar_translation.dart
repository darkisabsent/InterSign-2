import 'package:flutter/material.dart';
import 'package:inter_sign/const/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';

class AvatarTranslation extends StatefulWidget {
  const AvatarTranslation({super.key});

  @override
  _AvatarTranslationState createState() => _AvatarTranslationState();
}

class _AvatarTranslationState extends State<AvatarTranslation> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  List<String> _videoSequence = [];
  late VideoPlayerController _controller;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeSpeechToText();
    _initializeVideoPlayer();
  }

  void _initializeSpeechToText() async {
    _speech = stt.SpeechToText();
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (!available) {
      print('The user has denied the use of speech recognition.');
    }
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/videos/placeholder.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            _textController.text = _text;
          }),
        );
      }
    }
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speech.stop();
    _translateToSignLanguage(_textController.text);
  }

  void _translateToSignLanguage(String text) async {
    final response = await http.post(
      Uri.parse('$SERVER_URL/translate/'),
      body: {'text': text},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _videoSequence = List<String>.from(data['video']);
        _playVideoSequence();
      });
    } else {
      setState(() {
        _videoSequence = ['assets/videos/placeholder.mp4'];
        _playVideoSequence();
      });
    }
  }

  void _playVideoSequence() {
    if (_videoSequence.isNotEmpty) {
      _controller = VideoPlayerController.asset(_videoSequence.removeAt(0))
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
          _controller.addListener(() {
            if (!_controller.value.isPlaying &&
                _controller.value.isInitialized &&
                _controller.value.duration == _controller.value.position) {
              if (_videoSequence.isNotEmpty) {
                _playVideoSequence();
              }
            }
          });
        });
    }
  }

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatar Translation')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Enter Text or Use Mic',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    onPressed: _listen,
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: _stopListening,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _text,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }  
}
