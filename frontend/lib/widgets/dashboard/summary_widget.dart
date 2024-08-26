import 'package:flutter/material.dart';
import 'package:inter_sign/widgets/dashboard/pie_chart_widget.dart';
import 'package:inter_sign/widgets/dashboard/summary_details.dart';

import '../../const/constant.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Chart(),
            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            SummaryDetails(),
            /*SizedBox(height: 40),
            Scheduled(),*/
          ],
        ),
      ),
    );
  }
}
