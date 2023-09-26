import 'package:flutter/material.dart';

showLoadingSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.grey.shade500,
      duration: const Duration(seconds: 10),
    ),
  );
}

showSuccessSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.green.shade300,
      duration: const Duration(seconds: 2),
    ),
  );
}

showFailSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.red.shade300,
      duration: const Duration(seconds: 2),
    ),
  );
}

hideCurrentSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
