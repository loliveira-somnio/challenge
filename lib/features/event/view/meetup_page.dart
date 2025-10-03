import 'package:challenge/core/core.dart';
import 'package:challenge/data/data.dart';
import 'package:challenge/features/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetupPage extends StatelessWidget {
  const MeetupPage({super.key, this.id});

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
