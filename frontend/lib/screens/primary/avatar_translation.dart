import 'package:flutter/material.dart';

import '../../utils/responsive.dart';
import '../../widgets/dashboard/side_menu.dart';
import '../../widgets/dashboard/summary_widget.dart';

class AvatarTranslation extends StatelessWidget {
  const AvatarTranslation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
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
              flex: 10,
              child: Center(
                child: Text("AVATAR TRANSLATION"),
              ),
            ),
          ],
        ),
      ),
      /*body: const Center(
        child: Text("AVATAR TRANSLATION"),
      ),*/
    );
  }
}
