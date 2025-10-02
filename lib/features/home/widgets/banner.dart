import 'package:challenge/core/widgets/bookmark_toggle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventBanner extends StatelessWidget {
  const EventBanner({
    super.key,
    required this.imageSrc,
    this.title,
    required this.bookmarkAction,
    required this.isBookmarked,
    required this.description,
  });

  final String imageSrc;
  final String? title;
  final ValueChanged<bool> bookmarkAction;
  final bool isBookmarked;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: AspectRatio(
              aspectRatio: 380 / 205,
              child: Container(
                width: 380,
                height: 205,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageSrc),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        _BannerTitle(
          title: title,
          bookmarkAction: bookmarkAction,
          isBookmarked: isBookmarked,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _BannerTitle extends StatelessWidget {
  const _BannerTitle({
    required this.title,
    required this.isBookmarked,
    required this.bookmarkAction,
  });

  final String? title;
  final ValueChanged<bool> bookmarkAction;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        BookmarkToggle(
          isBookmarked: isBookmarked,
          onChanged: (value) => bookmarkAction(value),
        ),
      ],
    );
  }
}
