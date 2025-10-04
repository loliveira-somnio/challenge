import 'package:challenge/meetup/meetup.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetup_repository/meetup_repository.dart';

class MeetupPage extends StatelessWidget {
  const MeetupPage({super.key, this.id});

  static const path = '/meetup';
  static String pathWithId({required String id}) {
    return '$path/$id';
  }

  final String? id;

  @override
  Widget build(BuildContext context) {
    final initialEvent = id != null
        ? SpecificMeetupRequested(id: id!)
        : const LatestMeetupRequested();

    return BlocProvider(
      create: (context) =>
          MeetupBloc(context.read<MeetupRepository>())..add(initialEvent),
      child: Scaffold(appBar: DSAppBar.logo(), body: const MeetupView()),
    );
  }
}
