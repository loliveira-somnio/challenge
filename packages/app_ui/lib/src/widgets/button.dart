import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
    WidgetStateProperty<T> all<T>(T value) => WidgetStateProperty.all(value);

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          // backgroundColor: all(Theme.of(context).colorScheme.primary),
          // foregroundColor: all(Colors.white),
          // textStyle: all(
          //   const TextStyle(fontWeight: APPFontWeight.semiBold),
          // ),
          // padding: all(
          //   const EdgeInsets.symmetric(vertical: APPSpacing.lg),
          // ),
          ),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          if (icon != null) Icon(icon, color: Colors.white, size: 16)
        ],
      ),
    );
  }
}

class PrimaryButtonStyle extends ButtonStyle {
  const PrimaryButtonStyle();
  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateProperty.all(Colors.blueAccent);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateProperty.all(Colors.white);

  @override
  WidgetStateProperty<TextStyle?>? get textStyle =>
      WidgetStateProperty.all(TextStyle(fontWeight: FontWeight.w600));

  @override
  WidgetStateProperty<EdgeInsets?>? get padding =>
      WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16));
}
