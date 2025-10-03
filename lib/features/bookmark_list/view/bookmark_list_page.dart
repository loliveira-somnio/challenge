import 'package:challenge/core/core.dart';
import 'package:challenge/data/data.dart';
import 'package:challenge/features/bookmark_list/bookmark_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
