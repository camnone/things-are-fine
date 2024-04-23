import 'package:flutter/material.dart';

class SnackBarService {
  SnackBarService(
    this.context, {
    required this.message,
    this.error,
    this.closeIcon,
  });
  final BuildContext context;
  final String message;
  final bool? error, closeIcon;

  static const errorColor = Colors.red;
  static const okColor = Colors.green;

  Future<void> showSnackBar() async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.fixed,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      content: Row(
        children: [
          Expanded(
            child: Text(
              message,
              textAlign: closeIcon == true ? TextAlign.start : TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          if (closeIcon == true) ...[
            const SizedBox(width: 12),
            GestureDetector(
                onTap: () =>
                    ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                child: Icon(Icons.close))
          ]
        ],
      ),
      backgroundColor: error == true ? errorColor : okColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
