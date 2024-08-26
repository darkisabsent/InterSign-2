import 'package:flutter/material.dart';
import 'package:inter_sign/model/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.dashboard_outlined, title: "Dashboard"),
    MenuModel(icon: Icons.shopping_cart, title: "Subscription Plan"),
    MenuModel(icon: Icons.translate, title: "Avatar Translation"),
    MenuModel(icon: Icons.multitrack_audio, title: "Translate to Speech"),
    MenuModel(icon: Icons.settings, title: "Settings"),
    /*MenuModel(icon: Icons.payment, title: "Payment"),
    MenuModel(icon: Icons.account_circle_sharp, title: "Accounts"),
    MenuModel(icon: Icons.help, title: "Help"),*/
    //MenuModel(icon: Icons.dashboard_outlined, title: "Dashboard"),
  ];
}
