import 'package:challenge/core/core.dart';
import 'package:challenge/core/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/data/model/meetup_data.dart';
import 'package:challenge/features/bookmark_list/bloc/bookmark_list_bloc.dart';
import 'package:challenge/features/bookmark_list/bloc/bookmark_list_event.dart';
import 'package:challenge/features/bookmark_list/bloc/bookmark_list_state.dart';
import 'package:go_router/go_router.dart';

import 'widgets/bookmark_card.dart';

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
              backgroundColor: Colors.red,
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

  final List<MeetupData> bookmarkedMeetups;

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
          Icon(Icons.bookmark_border, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Nenhum favorito ainda',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Adicione alguns meetups aos seus favoritos',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.go(AppRouter.meetup());
            },
            icon: const Icon(Icons.explore),
            label: const Text('Explorar Meetups'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
