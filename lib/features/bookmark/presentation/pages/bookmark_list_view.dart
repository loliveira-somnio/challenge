import 'package:challenge/core/core.dart';
import 'package:challenge/features/bookmark/logic/bookmark_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/data/model/meetup_data.dart';
import 'package:challenge/features/bookmark/logic/bookmark_list_bloc.dart';
import 'package:challenge/features/bookmark/logic/bookmark_list_event.dart';
import 'package:challenge/features/bookmark/logic/bookmark_list_state.dart';
import 'package:challenge/features/bookmark/presentation/widgets/bookmark_toggle.dart';
import 'package:go_router/go_router.dart';

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
          return _buildEmptyState();
        }

        if (state is BookmarkListLoaded) {
          return _buildBookmarkList(state.bookmarkedMeetups);
        }

        if (state is BookmarkListFailure) {
          return _buildErrorState(state.errorMessage);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState() {
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

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Ops! Algo deu errado',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.red[600]),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBookmarkList(List<MeetupData> bookmarkedMeetups) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookmarkedMeetups.length,
      itemBuilder: (context, index) {
        final meetup = bookmarkedMeetups[index];
        return _buildBookmarkCard(meetup);
      },
    );
  }

  Widget _buildBookmarkCard(MeetupData meetup) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Navigate to meetup details if needed
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                meetup.bannerImageSrc,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          meetup.title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      BookmarkToggle(meetupId: meetup.id),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meetup.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        meetup.location,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        meetup.date,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
