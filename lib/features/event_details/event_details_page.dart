import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_details_view.dart';
import 'bloc/bloc.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailsBloc()..add(const EventDetailsStarted()),
      child: const EventDetailsView(),
    );
  }
}
