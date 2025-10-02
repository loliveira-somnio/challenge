import 'package:challenge/core/styles/primary_button.dart';
import 'package:flutter/material.dart';

class DSButton extends StatelessWidget {
  const DSButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  final VoidCallback onPressed;
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon != null
        ? Icon(icon!, color: Colors.white, size: 16)
        : null;

    return TextButton(
      onPressed: onPressed,
      style: PrimaryButtonStyle(),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(title), ?iconWidget],
      ),
    );
  }
}
