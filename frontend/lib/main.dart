import 'package:flutter/material.dart';
import 'package:inter_sign/screens/signup.dart';
import 'package:window_manager/window_manager.dart';
import 'package:inter_sign/themes/light_theme.dart';

void main() async {
  // Ensure that plugin services are initialized before using them
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the window manager
  await windowManager.ensureInitialized();

  // Set window properties
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 900),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    // Keep the title bar visible
    titleBarStyle: TitleBarStyle.normal,
    //titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inter Sign',
      theme: AppTheme.lightTheme,
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
      debugShowCheckedModeBanner: false,
      home: const SignUp(),
    );
  }
}
