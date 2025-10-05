import 'package:app_ui/app_ui.dart';
import 'package:challenge/bookmark/cubit/bookmark_cubit.dart';

import 'package:challenge/bookmark_list/bookmark_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetup_repository/meetup_repository.dart';

class BookmarkListPage extends StatelessWidget {
  const BookmarkListPage({super.key});

  static const path = '/bookmarks';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkListBloc(
        meetupRepository: context.read<MeetupRepository>(),
        bookmarkCubit: context.read<BookmarkCubit>(),
      ),
      child: Scaffold(
        appBar: DSAppBar.text(title: 'Favoritos'),
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 16),
          child: const BookmarkListView(),
        ),
      ),
    );
  }
}
