import 'package:flutter/material.dart';

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
