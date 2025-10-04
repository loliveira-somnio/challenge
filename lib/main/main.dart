import 'package:app_ui/app_ui.dart';
import 'package:challenge/core/core.dart';
import 'package:challenge/bookmark/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetup_repository/meetup_repository.dart';
import 'package:meetup_client/meetup_client.dart';

void main() {
  runApp(
    RepositoryProvider<MeetupRepository>(
      create: (_) => MeetupRepository(MeetupClient()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit(),
      child: MaterialApp.router(
        title: 'Challenge App',
        theme: APPTheme().lightTheme,
        darkTheme: APPTheme().darkTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
