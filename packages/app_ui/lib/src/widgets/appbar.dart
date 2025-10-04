import 'dart:ui';

import 'package:app_ui/src/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class DSAppBar extends AppBar {
  final String? titleText;

  DSAppBar.text({super.key, required String title}) : titleText = title;

  DSAppBar.logo({super.key}) : titleText = null;

  @override
  bool get forceMaterialTransparency => true;

  @override
  Widget get flexibleSpace => ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color:
                Colors.white.withValues(alpha: 0.1), // Adjust opacity for glass
          ),
        ),
      );

  @override
  bool? get centerTitle => false;

  @override
  Widget get title => titleText != null
      ? Text(titleText!, style: const TextStyle(fontSize: 20))
      : Assets.images.logo.image(width: 180);

  @override
  Color? get backgroundColor => Colors.white;
}
