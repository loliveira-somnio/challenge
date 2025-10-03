import 'package:challenge/core/core.dart';
import 'package:challenge/data/data.dart';
import 'package:challenge/features/bookmark_list/bookmark_list.dart';
import 'package:flutter/material.dart';

class MeetupBanner extends StatelessWidget {
  const MeetupBanner({
    super.key,
    required this.meetup,
    required this.bookmarkAction,
  });

  final MeetupData meetup;
  final ValueChanged<bool> bookmarkAction;

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
              child: Container(
                width: 380,
                height: 205,
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
                title: 'Onde',
                subtitle: meetup.location,
                leading: Icons.location_on,
              ),
              DSListTile(
                title: 'Quando',
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
