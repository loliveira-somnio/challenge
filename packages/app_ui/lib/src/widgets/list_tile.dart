import 'package:flutter/material.dart';

class DSListTile extends StatelessWidget {
  const DSListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
  });

  final String title;
  final String subtitle;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 50,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .primaryContainer
              .withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(leading, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
