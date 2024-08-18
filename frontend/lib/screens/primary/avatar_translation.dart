import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../utils/responsive.dart';
import '../../widgets/dashboard/side_menu.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:video_player/video_player.dart';

class AvatarTranslation extends StatefulWidget {
  const AvatarTranslation({super.key});

  @override
  State<AvatarTranslation> createState() => _AvatarTranslationState();
}

class _AvatarTranslationState extends State<AvatarTranslation> {
  late double initialWidth;
  late double initialHeight;
  bool _isMiniMode = false;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _getInitialDimensions();

    // Initialize the video controller
    _controller = VideoPlayerController.asset('assets/videos/sample_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        if (_isMiniMode) {
          _controller.play();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop && !_isMiniMode
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      appBar: !_isMiniMode ? AppBar() : null,
      floatingActionButton: FloatingActionButton(
        onPressed: _setWindowAlwaysOnTop,
        child: const Icon(Icons.layers),
      ),
      body: SafeArea(
        child: _isMiniMode
            ? Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const CircularProgressIndicator(),
              )
            : Row(
                children: [
                  if (isDesktop && !_isMiniMode)
                    const Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: SideMenuWidget(),
                      ),
                    ),
                  const Expanded(
                    flex: 10,
                    child: Center(
                      child: Text("AVATAR TRANSLATION"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _getInitialDimensions() async {
    // Fetch the initial screen dimensions
    final screenSize = await windowManager.getBounds();

    setState(() {
      initialWidth = screenSize.width;
      initialHeight = screenSize.height;
    });
  }

  void _setWindowAlwaysOnTop() async {
    setState(() {
      _isMiniMode = !_isMiniMode;
    });

    if (_isMiniMode) {
      await windowManager.setAlwaysOnTop(true);

      Size windowSize = await windowManager.getSize();
      double currentWidth = windowSize.width;
      double currentHeight = windowSize.height;

      double windowWidth = currentWidth * 0.4;
      double windowHeight = currentHeight * 0.30;

      await windowManager.setSize(Size(windowWidth, windowHeight));

      /// Set the position to top-right
      double x = currentWidth * 0.87;
      double y = 0; // Top position

      /// Set the window position to the top-right corner
      await windowManager.setPosition(Offset(x, 0));

      /// Play the video when in mini mode
      _controller.play();
    } else {
      /// Unset window to always on top
      await windowManager.setAlwaysOnTop(false);

      /// Reset the window to the initial dimensions
      await windowManager.setSize(Size(initialWidth, initialHeight));

      /// Center the window on the screen
      await windowManager.center();

      // Pause the video when not in mini mode
      _controller.pause();
    }
  }
}
