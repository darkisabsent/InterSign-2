import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class AuthInfoCard extends StatelessWidget {
  const AuthInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isDesktop = Responsive.isDesktop(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff735ff1),
            Color(0xff625ff1),
          ],
        ),
      ),
      child: Center(
        child: SizedBox(
          width: isDesktop
              ? screenWidth * 0.40
              : isTablet
              ? screenWidth * 0.35
              : screenWidth * 0.3,
          height: isDesktop
              ? screenHeight * 0.7
              : isTablet
              ? screenHeight * 0.6
              : screenHeight * 0.5,
          child: Card(
            color: const Color(0xffaea2f7),
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Stack(
              children: [
                const Positioned(
                  top: 30,
                  left: 40,
                  child: Text(
                    '"I will be your\n personal\n interpreter\n today"',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/avatar_image.png',
                    height: isMobile
                        ? screenHeight * 0.4
                        : screenHeight * 0.5,
                    width: isMobile
                        ? screenWidth * 0.2
                        : screenWidth * 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
