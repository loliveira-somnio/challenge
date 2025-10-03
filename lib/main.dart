import 'package:challenge/core/core.dart';
import 'package:challenge/data/repository/meetup_repository.dart';
import 'package:challenge/data/services/meetup_service.dart';
import 'package:challenge/features/bookmark/logic/bookmark_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    RepositoryProvider<MeetupRepository>(
      create: (_) => MeetupRepositoryImpl(MeetupService()),
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
