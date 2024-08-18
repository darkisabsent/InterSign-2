import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_sign/const/constant.dart';

import '../../utils/responsive.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final bool isTablet = Responsive.isTablet(context);
    final bool isDesktop = Responsive.isDesktop(context);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Flexible(
                  child: Text(
                "Subscription Plan",
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
              )),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      "Choose The Subscription Model That Suits You",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          "Bill Monthly",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CupertinoSwitch(
                          activeColor: Colors.indigo,
                          value: isSwitched,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Bill Annually",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: isDesktop
                        ? screenWidth * 0.3
                        : isTablet
                            ? screenWidth * 0.25
                            : screenWidth * 0.2,
                    height: isDesktop
                        ? screenHeight * 0.55
                        : isTablet
                            ? screenHeight * 0.45
                            : screenHeight * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff3e0933),
                          Color(0xff140744),
                        ],
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "BASIC PLAN",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "❌ Avatar Up To 480p Resolution",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "❌ Up to 8 Hours Of Translation Per Day",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "❌ Sign Language To Speech",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "❌ Customize Avatars",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "❌ Customize Voice",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: -50,
                                bottom: 20,
                                child: Image.asset(
                                  'assets/images/avatar_2.png',
                                  height: isMobile
                                      ? screenHeight * 0.22
                                      : screenHeight * 0.32,
                                  width: isMobile
                                      ? screenWidth * 0.1
                                      : screenWidth * 0.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: isDesktop
                        ? screenWidth * 0.3
                        : isTablet
                            ? screenWidth * 0.25
                            : screenWidth * 0.2,
                    height: isDesktop
                        ? screenHeight * 0.55
                        : isTablet
                            ? screenHeight * 0.45
                            : screenHeight * 0.4,
                    color: Colors.white,
                    child: Card(
                      elevation: 2,
                      child: Stack(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "PREMIUM PLAN",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text("✅ Avatar Up To 1080p Resolution"),
                                const SizedBox(height: 20),
                                Text("✅ Unlimited translation Hours Per Day"),
                                const SizedBox(height: 20),
                                Text("✅Enahnced sign language to speech"),
                                const SizedBox(height: 20),
                                Text("✅ Customize Avatars"),
                                const SizedBox(height: 20),
                                Text("✅ Customize Voice"),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: -40,
                            child: Image.asset(
                              'assets/images/avatar_image.png',
                              height: isMobile
                                  ? screenHeight * 0.5
                                  : screenHeight * 0.4,
                              width: isMobile
                                  ? screenWidth * 0.1
                                  : screenWidth * 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
