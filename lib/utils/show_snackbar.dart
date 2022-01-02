import 'package:flutter/material.dart';

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.

showSnack(BuildContext context, String message, Color color,
    {Color? textColor, Duration? duration}) {
  SnackBar snackBar = SnackBar(
    backgroundColor: color,
    duration: duration ?? const Duration(seconds: 1),
    content: Text(
      message,
      style: TextStyle(color: textColor ?? Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
