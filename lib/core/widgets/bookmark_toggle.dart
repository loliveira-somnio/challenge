import 'package:flutter/material.dart';

class BookmarkToggle extends StatelessWidget {
  const BookmarkToggle({
    super.key,
    this.isBookmarked = false,
    this.onChanged,
    this.size = 24.0,
    this.color,
    this.bookmarkedColor,
  });

  final bool isBookmarked;
  final ValueChanged<bool>? onChanged;
  final double size;
  final Color? color;
  final Color? bookmarkedColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onChanged?.call(!isBookmarked);
      },
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        size: size,
        color: isBookmarked
            ? (bookmarkedColor ?? Colors.blue)
            : (color ?? Colors.grey),
      ),
      splashRadius: size * 0.8,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: size + 16, minHeight: size + 16),
    );
  }
}
