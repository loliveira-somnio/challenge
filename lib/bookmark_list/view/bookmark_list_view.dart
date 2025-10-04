import 'package:app_ui/app_ui.dart';
import 'package:challenge/core/core.dart';

import 'package:challenge/bookmark_list/bookmark_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meetup_repository/meetup_repository.dart';

class BookmarkListView extends StatefulWidget {
  const BookmarkListView({super.key});

  @override
  State<BookmarkListView> createState() => _BookmarkListViewState();
}

class _BookmarkListViewState extends State<BookmarkListView> {
  @override
  void initState() {
    super.initState();
    context.read<BookmarkListBloc>().add(const BookmarkListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarkListBloc, BookmarkListState>(
      listener: (context, state) {
        if (state is BookmarkListFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is BookmarkListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookmarkListEmpty) {
          return _BookmarkListEmptyState();
        }

        if (state is BookmarkListLoaded) {
          return _BookmarkListBody(bookmarkedMeetups: state.bookmarkedMeetups);
        }

        if (state is BookmarkListFailure) {
          return Center(child: ErrorMessage(errorMessage: state.errorMessage));
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BookmarkListBody extends StatelessWidget {
  const _BookmarkListBody({required this.bookmarkedMeetups});

  final List<Meetup> bookmarkedMeetups;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookmarkedMeetups.length,
      itemBuilder: (context, index) {
        final meetup = bookmarkedMeetups[index];
        return BookmarkCard(meetup: meetup);
      },
    );
  }
}

class _BookmarkListEmptyState extends StatelessWidget {
  const _BookmarkListEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border,
              size: 80,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6)),
          const SizedBox(height: 16),
          Text(
            'Nenhum favorito ainda',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione alguns meetups aos seus favoritos',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            onPressed: () {
              context.go(AppRouter.meetup());
            },
            title: 'Explorar Meetups',
            icon: Icons.explore,
          ),
        ],
      ),
    );
  }
}
