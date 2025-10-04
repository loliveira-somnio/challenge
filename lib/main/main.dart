import 'package:challenge/app/view/app.dart';
import 'package:challenge/bookmark/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetup_repository/meetup_repository.dart';
import 'package:meetup_client/meetup_client.dart';

void main() {
  runApp(
    RepositoryProvider<MeetupRepository>(
      create: (_) => MeetupRepository(MeetupClient()),
      child: BlocProvider(
        create: (context) => BookmarkCubit(),
        child: const AppView(),
      ),
    ),
  );
}
