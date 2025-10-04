import 'dart:ui';

import 'package:app_ui/src/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class DSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;

  DSAppBar.text({super.key, required String title}) : titleText = title;

  DSAppBar.logo({super.key}) : titleText = null;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Theme.of(context)
                .colorScheme
                .surface
                .withValues(alpha: 0.1), // Adjust opacity for glass
          ),
        ),
      ),
      centerTitle: false,
      title: titleText != null
          ? Text(titleText!, style: const TextStyle(fontSize: 20))
          : Assets.images.logo.image(width: 180),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
