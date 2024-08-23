import 'package:flutter/material.dart';
import 'package:inter_sign/const/constant.dart';
import 'package:ionicons/ionicons.dart';

class ForwardButton extends StatelessWidget {
  final Function() onTap;

  const ForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: purpleColor,
        ),
      ),
    );
  }
}
