import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../widgets/side_menu.dart';
import '../../widgets/header_widget.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

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
            const Expanded(
              flex: 7,
              child: Center(
                child: Text("ACCOUNTS"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
