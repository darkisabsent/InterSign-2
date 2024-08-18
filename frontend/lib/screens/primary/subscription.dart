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
              const Spacer(),
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
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "BASIC PLAN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "❌ Avatar Up To 480p Resolution",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "❌ Up to 8 Hours Of Translation\n      Per Day",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "❌ Sign Language To Speech",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "❌ Customize Avatars",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "❌ Customize Voice",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "\$30",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Text(
                                            "/month",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text("Choose"),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -15,
                            bottom: 60,
                            child: Image.asset(
                              'assets/images/avatar_2.png',
                              height: isMobile
                                  ? screenHeight * 0.20
                                  : screenHeight * 0.25,
                              width: isMobile
                                  ? screenWidth * 0.1
                                  : screenWidth * 0.2,
                            ),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "BASIC PLAN",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 16, top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("✅ Avatar Up To 480p Resolution"),
                                      Text(
                                          "✅ Up to 8 Hours Of Translation\n      Per Day"),
                                      Text("✅ Sign Language To Speech"),
                                      Text("✅ Customize Avatars"),
                                      Text("✅ Customize Voice"),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 20),
                                  child: Column(
                                    children: [
                                      const Row(
                                        children: [
                                          Text("\$50"),
                                          Text("/month"),
                                        ],
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: primaryColor),
                                          child: const Text(
                                            "Choose",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: -2,
                            bottom: -5,
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
