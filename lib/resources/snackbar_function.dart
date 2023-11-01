import 'package:flutter/material.dart';

showSnackBar({
  required String content,
  required ScaffoldMessengerState scaffoldMessengerState,
}) {
  scaffoldMessengerState.showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
