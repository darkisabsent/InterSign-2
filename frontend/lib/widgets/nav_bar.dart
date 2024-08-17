import 'package:flutter/material.dart';
import 'package:inter_sign/screens/primary/index.dart';
import 'package:inter_sign/screens/other/index.dart';

class NavBar extends StatelessWidget {
  final Function(int) onItemSelected;

  const NavBar({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inter",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 5),
                Image.asset(
                  'assets/images/avatar_image.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(width: 5),
                Text(
                  "Sign",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text("Dashboard"),
            onTap: () {
              onItemSelected(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Subscription Plan"),
            onTap: () {
              onItemSelected(1); // Pass the index to the callback
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text("Avatar Translation"),
            onTap: () {
              onItemSelected(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.multitrack_audio),
            title: const Text("Translate to Speech"),
            onTap: () {
              onItemSelected(3);
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("OTHERS"),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              onItemSelected(5);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment"),
            onTap: () {
              onItemSelected(5);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_sharp),
            title: const Text("Accounts"),
            onTap: () {
              onItemSelected(6);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help"),
            onTap: () {
              onItemSelected(7);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
