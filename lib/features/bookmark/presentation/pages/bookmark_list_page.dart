import 'package:challenge/core/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/data/repository/meetup_repository.dart';
import 'package:challenge/features/bookmark/logic/bookmark_cubit.dart';
import 'package:challenge/features/bookmark/logic/bookmark_list_bloc.dart';

import 'bookmark_list_view.dart';

class BookmarkListPage extends StatelessWidget {
  const BookmarkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkListBloc(
        meetupRepository: context.read<MeetupRepository>(),
        bookmarkCubit: context.read<BookmarkCubit>(),
      ),
      child: Scaffold(
        appBar: DSAppBar.text(title: 'Favoritos'),
        body: const BookmarkListView(),
      ),
    );
  }
}
