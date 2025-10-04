import 'package:challenge/bookmark/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkToggle extends StatelessWidget {
  const BookmarkToggle({super.key, required this.meetupId});
  final String meetupId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, Set<String>>(
      builder: (context, state) {
        final cubit = context.read<BookmarkCubit>();
        final isBookmarked = cubit.isBookmarked(meetupId);
        return IconButton(
          onPressed: () {
            cubit.toggleBookmark(meetupId);
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            size: 24,
            color: isBookmarked
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
          ),
          splashRadius: 24 * 0.8,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 24 + 16, minHeight: 24 + 16),
        );
      },
    );
  }
}
