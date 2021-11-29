import 'package:flutter/material.dart';

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.

showSnack(BuildContext context, String message, Color color) {
  SnackBar snackBar = SnackBar(
    backgroundColor: color,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
