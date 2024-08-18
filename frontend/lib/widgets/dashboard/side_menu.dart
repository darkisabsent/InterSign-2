import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inter_sign/utils/navigation/menu_state.dart';
import 'package:inter_sign/const/constant.dart';
import 'package:inter_sign/screens/other/index.dart';
import 'package:inter_sign/screens/primary/index.dart';
import '../../data/dashboard/side_menu_data.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();
    final selectedIndex = context.watch<MenuState>().selectedIndex;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: whiteColor,
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) =>
            buildMenuEntry(context, data, index, selectedIndex),
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
          context.read<MenuState>().updateIndex(index);

          /// Handle navigation based on the index

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Subscription()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AvatarTranslation()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TranslateToSpeech()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            );
          } else if (index == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Payment()),
            );
          } else if (index == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Accounts()),
            );
          } else if (index == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Help()),
            );
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
