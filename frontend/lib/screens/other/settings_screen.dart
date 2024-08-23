import 'package:flutter/material.dart';
import 'package:inter_sign/screens/other/customize_avatar.dart';
import 'package:ionicons/ionicons.dart';

import '../../utils/responsive.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/settings/forward_button.dart';
import '../../widgets/settings/setting_item.dart';
import '../../widgets/side_menu.dart';
import 'edit_account.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        title: const HeaderWidget(),
      ),
      body: Row(
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
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Image.asset("assets/images/no_profile.png",
                            width: 70, height: 70),
                        const SizedBox(width: 20),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Doe",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Packaged",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        ForwardButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditAccountScreen(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: "Customize Avatar",
                    icon: Ionicons.person_add,
                    bgColor: Colors.green.shade100,
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CustomizeAvatar()));
                    },
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: "Security",
                    icon: Ionicons.lock_closed,
                    bgColor: Colors.blue.shade100,
                    iconColor: Colors.blue,
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: "Language",
                    icon: Ionicons.earth,
                    bgColor: Colors.orange.shade100,
                    iconColor: Colors.orange,
                    value: "English",
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  SettingItem(
                    title: "Help",
                    icon: Ionicons.nuclear,
                    bgColor: Colors.red.shade100,
                    iconColor: Colors.red,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}