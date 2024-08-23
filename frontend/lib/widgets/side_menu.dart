import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inter_sign/utils/navigation/menu_state.dart';
import 'package:inter_sign/const/constant.dart';
import 'package:inter_sign/screens/other/index.dart';
import 'package:inter_sign/screens/primary/index.dart';
import '../data/dashboard/side_menu_data.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();
    final selectedIndex = context.watch<MenuState>().selectedIndex;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: whiteColor,
      child: Column(
        children: [
          //const SideMenuLogo(),
          Expanded(
            child: ListView.builder(
              itemCount: data.menu.length,
              itemBuilder: (context, index) =>
                  buildMenuEntry(context, data, index, selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuEntry(
      BuildContext context, SideMenuData data, int index, int selectedIndex) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
        color:
            isSelected ? Theme.of(context).highlightColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          if (selectedIndex != index) {
            context.read<MenuState>().updateIndex(index);

            if (index == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
                (route) => false,
              );
            } else if (index == 1) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Subscription()),
                (route) => false,
              );
            } else if (index == 2) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const AvatarTranslation()),
                (route) => false,
              );
            } else if (index == 3) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const TranslateToSpeech()),
                (route) => false,
              );
            } else if (index == 4) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
                (route) => false,
              );
            } else if (index == 5) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Payment()),
                (route) => false,
              );
            } else if (index == 6) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Accounts()),
                (route) => false,
              );
            } else if (index == 7) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Help()),
                (route) => false,
              );
            }
          }
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Flexible(
              child: Text(
                data.menu[index].title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
