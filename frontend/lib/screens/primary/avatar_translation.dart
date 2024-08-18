import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import 'package:video_player_win/video_player_win.dart';

class AvatarTranslation extends StatefulWidget {
  @override
  _AvatarTranslationState createState() => _AvatarTranslationState();
}

class _AvatarTranslationState extends State<AvatarTranslation>
    with WidgetsBindingObserver {
  WinVideoPlayerController? _controller;
  List<String> _videoUrls = [];
  int _currentVideoIndex = 0;
  String _text = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller?.play();
    }
  }

  void _initializeVideoPlayer(String url) {
    print('Initializing video player with URL: $url');
    _controller = WinVideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _controller?.play();
        });
        _controller?.addListener(_videoListener);
      }).catchError((error) {
        print('Error initializing video: $error');
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
    print('Submit button clicked');
    print('Text to be translated: $_text'); // Debug statement
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/translate_text'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'text': _text,
        }),
      );
      if (response.statusCode == 200) {
        final videoUrls = (jsonDecode(response.body)['video'] as List)
            .map((url) => 'http://localhost:8000/$url')
            .toList();
        setState(() {
          _videoUrls = videoUrls;
          _currentVideoIndex = 0;
          print('Video URLs received: $_videoUrls');
        });
        _playNextVideo();
      } else {
        print('Failed to load video URLs. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e, stackTrace) {
      print('Error occurred during HTTP request: $e');
      print('Stack trace: $stackTrace');
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
      print('Playing video: $videoUrl');
      _initializeVideoPlayer(videoUrl);
      _currentVideoIndex++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Translation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_controller != null && _controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: WinVideoPlayer(_controller!),
              ),
            TextField(
              onChanged: (text) {
                _text = text;
              },
              decoration: InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
