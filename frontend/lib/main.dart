import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inter_sign/utils/navigation/menu_state.dart';
import 'package:provider/provider.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:window_manager/window_manager.dart';
import 'package:inter_sign/themes/light_theme.dart';

import 'auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  VideoPlayerMediaKit.ensureInitialized(
    android: true,
    windows: true,
  );

  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(const Size(700, 700));
  }

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    // minimumSize: Size(700, 600),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    // await windowManager.setMinimumSize(const Size(700, 600));
    await windowManager.show();
    await windowManager.focus();
  });

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
      //home: const SignupScreen(),
      home: const AuthGate(),
    );
  }
}
