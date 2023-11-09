import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: Colors.cyanAccent.shade700,
        height: 50,
        minWidth: double.maxFinite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,
        child: loading
            ? const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              )
            : Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ));
  }
}
