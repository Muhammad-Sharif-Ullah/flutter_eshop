import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Helloe",
          style: Theme.of(context)
              .textTheme
              .headline1
              ?.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
