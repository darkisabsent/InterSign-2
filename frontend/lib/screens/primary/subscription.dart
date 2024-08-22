import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_sign/const/constant.dart';
import 'package:inter_sign/widgets/side_menu.dart';

import '../../utils/responsive.dart';
import '../../utils/layout_utils.dart';
import '../../widgets/header_widget.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),

        /*title: Text(
          "Subscription Plan",
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 1,
        ),
        centerTitle: true,*/
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
            Expanded(
              flex: 7,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppPadding.p30(context)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: AppPadding.p10(context)),
                    Row(
                      children: [
                        SizedBox(width: AppPadding.p5(context)),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p5(context)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPlanCard(
                            context,
                            isDesktop,
                            isTablet,
                            isMobile,
                            "BASIC PLAN",
                            "assets/images/rs_avatar_image_1.png",
                            false),
                        _buildPlanCard(
                            context,
                            isDesktop,
                            isTablet,
                            isMobile,
                            "PREMIUM PLAN",
                            "assets/images/rs_avatar_image_2.png",
                            true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, bool isDesktop, bool isTablet,
      bool isMobile, String planName, String imagePath, bool isPremium) {
    return Container(
      width: isDesktop
          ? ScreenSize.adjustedWidth(context, 30)
          : isTablet
              ? ScreenSize.adjustedWidth(context, 25)
              : ScreenSize.adjustedWidth(context, 20),
      height: isDesktop
          ? ScreenSize.adjustedHeight(context, 55)
          : isTablet
              ? ScreenSize.adjustedHeight(context, 45)
              : ScreenSize.adjustedHeight(context, 40),
      decoration: isPremium
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
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
        elevation: isPremium ? 2 : 0,
        color: isPremium ? Colors.white : Colors.transparent,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p10(context), left: AppPadding.p20(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      planName,
                      style: TextStyle(
                        color: isPremium ? Colors.black : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._buildPlanDetails(context, isPremium),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p20(context),
                        bottom: AppPadding.p50(context)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              isPremium ? "\$50" : "\$30",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "/month",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isPremium ? purpleColor : secondaryColor,
                            ),
                            child: Text(
                              isPremium ? "Try 1 month" : "Choose",
                              style: TextStyle(
                                  color:
                                      isPremium ? secondaryColor : purpleColor),
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
              left: 150,
              top: 150,
              child: Image.asset(
                imagePath,
                height: isMobile
                    ? ScreenSize.adjustedHeight(context, 15)
                    : ScreenSize.adjustedHeight(context, 20),
                width: isMobile
                    ? ScreenSize.adjustedWidth(context, 10)
                    : ScreenSize.adjustedWidth(context, 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPlanDetails(BuildContext context, bool isPremium) {
    if (isPremium) {
      return const [
        Text("✅ Avatar Up To 1080p Resolution"),
        Text("✅ Unlimited Translation Hours"),
        Text("✅ Enhanced Sign Language\n     To Speech"),
        Text("✅ Customizable Avatars"),
        Text("✅ Customizable Voice"),
      ];
    } else {
      return const [
        Text(
          "❌ Avatar Up To 480p Resolution",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "❌ Up to 8 Hours Of Translation\n     Per Day",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "❌ Sign Language To Speech",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "❌ Customizable Avatars",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "❌ Customizable Voice",
          style: TextStyle(color: Colors.white),
        ),
      ];
    }
  }
}
