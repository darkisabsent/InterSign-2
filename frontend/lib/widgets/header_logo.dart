import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Flexible(
          child: Text(
            "Inter",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(width: 2),
        Image.asset(
          'assets/images/avatar_image.png',
          height: isMobile ? screenHeight * 0.05 : screenHeight * 0.1,
          width: isMobile ? screenWidth * 0.02 : screenWidth * 0.05,
        ),
        const SizedBox(width: 2),
        Flexible(
          child: Text(
            "Sign",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        )
      ],
    );
  }
}
