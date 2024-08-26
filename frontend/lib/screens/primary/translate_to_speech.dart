import 'package:flutter/material.dart';
import 'package:inter_sign/screens/primary/video_recorder.dart';

import '../../utils/responsive.dart';
import '../../widgets/side_menu.dart';
import '../../widgets/header_widget.dart';

class TranslateToSpeech extends StatelessWidget {
  const TranslateToSpeech({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
      ),
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
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
              child: VideoRecorder(),
            )
          ],
        ),
      ),
    );
  }
}
