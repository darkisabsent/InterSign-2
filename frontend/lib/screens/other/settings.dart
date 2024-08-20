import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../widgets/dashboard/side_menu.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(),
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
            const Expanded(
              flex: 7,
              child: Center(
                child: Text("SETTINGS"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
