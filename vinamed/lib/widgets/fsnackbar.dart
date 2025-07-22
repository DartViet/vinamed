import 'package:flutter/material.dart';

showFSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  final snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 5), showCloseIcon: true);

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
