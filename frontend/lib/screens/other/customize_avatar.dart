import 'package:flutter/material.dart';
import 'package:inter_sign/const/constant.dart';

import '../../utils/layout_utils.dart';
import '../../utils/responsive.dart';
import '../../widgets/header_widget.dart';

class CustomizeAvatar extends StatelessWidget {
  const CustomizeAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);

    final double containerWidth = isDesktop
        ? ScreenSize.adjustedWidth(context, 30)
        : isTablet
            ? ScreenSize.adjustedWidth(context, 40)
            : ScreenSize.adjustedWidth(context, 45);

    final double containerHeight = isDesktop
        ? ScreenSize.adjustedHeight(context, 62)
        : isTablet
            ? ScreenSize.adjustedHeight(context, 52)
            : ScreenSize.adjustedHeight(context, 47);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
      ),

      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  width: containerWidth * 2.1,
                  height: containerHeight * 1.1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Card(
                    color: cardBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: containerWidth * 0.9,
                              height: containerHeight * 0.7,
                              color: Colors.black87,
                              child: Image.asset(
                                'assets/images/customize_avatar.png',
                                fit: BoxFit.contain,
                              )),
                          SizedBox(
                            width: containerWidth * 0.9,
                            height: containerHeight * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: purpleColor,
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Create Avatar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: purpleColor,
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Customize Avatar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "Remove Avatar",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
