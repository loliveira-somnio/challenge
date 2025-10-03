import 'package:challenge/data/repository/meetup_repository.dart';
import 'package:challenge/features/event/bloc/meetup_bloc.dart';
import 'package:challenge/features/event/bloc/meetup_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/appbar.dart';
import 'meetup_view.dart';

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
