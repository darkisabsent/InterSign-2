import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class SideMenuLogo extends StatelessWidget {
  const SideMenuLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        const Flexible(
          child: Text(
            "Inter",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(width: 2),
        Image.asset(
          'assets/images/avatar_image.png',
          height: isMobile ? screenHeight * 0.05 : screenHeight * 0.1,
          width: isMobile ? screenWidth * 0.02 : screenWidth * 0.05,
        ),
        const SizedBox(width: 2),
        const Flexible(
          child: Text(
            "Sign",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
