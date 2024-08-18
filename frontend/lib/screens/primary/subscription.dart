import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Flexible(
                  child: Text(
                "Subscription Plan",
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
              )),
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 5,),
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
    );
  }
}
