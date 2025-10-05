import 'package:app_ui/app_ui.dart';
import 'package:challenge/bookmark/bookmark.dart';
import 'package:challenge/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:meetup_repository/meetup_repository.dart';

class MeetupBanner extends StatelessWidget {
  const MeetupBanner({
    super.key,
    required this.meetup,
  });

  final Meetup meetup;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: AspectRatio(
              aspectRatio: 380 / 205,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(meetup.bannerImageSrc),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                meetup.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            BookmarkToggle(meetupId: meetup.id),
          ],
        ),
        Text(
          meetup.description,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            spacing: 8,
            children: [
              DSListTile(
                title: context.l10n.where,
                subtitle: meetup.location,
                leading: Icons.location_on,
              ),
              DSListTile(
                title: context.l10n.when,
                subtitle: meetup.date,
                leading: Icons.event,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
