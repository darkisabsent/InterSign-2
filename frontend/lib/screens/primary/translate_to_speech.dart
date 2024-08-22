import 'package:flutter/material.dart';
import 'package:inter_sign/screens/primary/video_recorder.dart';

import '../../utils/responsive.dart';
import '../../widgets/side_menu.dart';
import '../../widgets/header_widget.dart';

class TranslateToSpeech extends StatelessWidget {
  const TranslateToSpeech({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VideoRecorder()),
                  );
                },
                child: const Text("Record Video"),
              )),
            )
          ],
        ),
      ),
    );
  }
}
