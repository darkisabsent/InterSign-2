import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inter",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
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
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text("Dashboard"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Subscription Plan"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text("Avatar Translation"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.multitrack_audio),
            title: const Text("Translate to Speech"),
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("OTHERS"),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_sharp),
            title: const Text("Accounts"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
