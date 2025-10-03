import 'package:challenge/core/router/app_router.dart';
import 'package:challenge/features/event/bloc/meetup_bloc.dart';
import 'package:challenge/features/event/bloc/meetup_state.dart';
import 'package:challenge/features/event/view/widgets/meetup_banner.dart';
import 'package:challenge/features/event/view/widgets/carousel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/error_message.dart';

class MeetupView extends StatelessWidget {
  const MeetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<MeetupBloc, MeetupState>(
        builder: (context, state) {
          switch (state) {
            case MeetupLoading() || MeetupInitial():
              return const Center(child: CircularProgressIndicator());

            case MeetupFailure():
              return Center(
                child: ErrorMessage(errorMessage: state.errorMessage),
              );

            case LatestMeetupLoaded():
              return _LatestMeetupViewBody(state: state);

            case SpecificMeetupLoaded():
              return _SpecificMeetupViewBody(state: state);
          }
        },
      ),
    );
  }
}

class _LatestMeetupViewBody extends StatelessWidget {
  final LatestMeetupLoaded state;

  const _LatestMeetupViewBody({required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Próximo Evento',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              MeetupBanner(
                meetup: state.currentEvent,
                bookmarkAction: (value) {},
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Carousel(
              title: 'Eventos anteriores',
              items: state.previousEvents
                  .map(
                    (event) => CarouselItem(
                      title: event.title,
                      image: event.smallImageSrc,
                      onTap: () {
                        context.go(AppRouter.meetup(id: event.id));
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SpecificMeetupViewBody extends StatelessWidget {
  final SpecificMeetupLoaded state;

  const _SpecificMeetupViewBody({required this.state});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8),
      child: MeetupBanner(meetup: state.event, bookmarkAction: (value) {}),
    );
  }
}
