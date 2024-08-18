import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Flexible(
                      child: Text(
                    "Subscription Plan",
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  )),
                  Row(
                    children: [
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
