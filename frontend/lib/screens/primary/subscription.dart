import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                  child: Text(
                "Subscription Plan",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                //style: Theme.of(context).textTheme.bodyMedium,
              )),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Choose The Subscription Model That Suits You",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
