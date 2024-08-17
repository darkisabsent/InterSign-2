import 'package:flutter/material.dart';
import 'package:inter_sign/screens/auth/signup_screen.dart';
import 'package:inter_sign/utils/navigation/menu_state.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:inter_sign/themes/light_theme.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart'; // Import the package

class MyVideoPlayerPlatform extends VideoPlayerPlatform {
  @override
  Future<void> init() async {
    // Your platform-specific initialization code here.
    print("Video player initialized");
  }

  // Implement other methods as needed.
}

void main() async {
  /// Ensure that plugin services are initialized before using them
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the window manager
  await windowManager.ensureInitialized();

  /// Set window properties
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,

    /// Keep the title bar visible
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  /// Register the custom VideoPlayerPlatform implementation
  VideoPlayerPlatform.instance = MyVideoPlayerPlatform();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MenuState())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inter Sign',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
    );
  }
}
