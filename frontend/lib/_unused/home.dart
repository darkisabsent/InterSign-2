/*
import 'package:flutter/material.dart';
import 'package:inter_sign/_unused/nav_bar.dart';
import 'package:window_manager/window_manager.dart';
import 'package:inter_sign/screens/primary/index.dart';
import 'package:inter_sign/screens/other/index.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _clickCount = 0; // Counter for button presses
  late double initialWidth;
  late double initialHeight;

  int _selectedIndex = 0; // Track the selected screen

  final List<Widget> _screens = [
    const Dashboard(),
    const Subscription(),
    AvatarTranslation(),
    const TranslateToSpeech(),
    //const Settings(),
    const Payment(),
    const Accounts(),
    const Help(),
  ];

  @override
  void initState() {
    super.initState();
    _getInitialDimensions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      drawer: NavBar(onItemSelected: _onItemSelected),
      body: _screens[_selectedIndex],
      //body: const Center(child: Text("Welcome!")),
      floatingActionButton: FloatingActionButton(
        onPressed: _setWindowAlwaysOnTop,
        child: const Icon(Icons.layers),
      ),
    );
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
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
    _clickCount += 1; // Increment the click count

    // Get the current window size
    Size windowSize = await windowManager.getSize();
    double currentWidth = windowSize.width;
    double currentHeight = windowSize.height;

    if (_clickCount == 2) {
      _clickCount = 0; // Reset the counter

      // Unset window to always on top
      await windowManager.setAlwaysOnTop(false);

      // Reset the window to the initial dimensions
      await windowManager.setSize(Size(initialWidth, initialHeight));

      // Center the window on the screen
      await windowManager.center();
    } else {
      // Set window to always on top
      await windowManager.setAlwaysOnTop(true);

      // Calculate 40% of screen width and 30% of screen height
      double windowWidth = currentWidth * 0.40;
      double windowHeight = currentHeight * 0.30;

      // Set the window size to 20% width and 10% height
      await windowManager.setSize(Size(windowWidth, windowHeight));

      // Set the position to top-right
      // Screen width and y position for the window
      double x = 1920 - currentWidth;
      double y = 0; // Top position

      // Set the window position to the top-right corner
      await windowManager.setPosition(Offset(x, y));
    }
  }
}
*/
