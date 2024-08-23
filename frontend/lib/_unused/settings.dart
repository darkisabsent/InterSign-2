import 'package:flutter/material.dart';
import 'package:inter_sign/screens/other/settings_screen.dart';

import '../utils/responsive.dart';
import '../widgets/side_menu.dart';
import '../widgets/header_widget.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
      ),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              const Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(),
                ),
              ),
            Expanded(
              flex: 7,
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text("Settings")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
