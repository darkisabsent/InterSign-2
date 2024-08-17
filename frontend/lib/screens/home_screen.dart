import 'package:flutter/material.dart';
import 'package:inter_sign/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                //child: Container(color: Colors.green),
                child: SizedBox(
                  child: SideMenuWidget(),
                )),
            Expanded(
              flex: 7,
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(color: Colors.green),
            )
          ],
        ),
      ),
    );
  }
}
