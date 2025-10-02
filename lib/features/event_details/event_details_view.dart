import 'package:challenge/core/widgets/appbar.dart';
import 'package:challenge/core/widgets/list_tile.dart';
import 'package:challenge/features/event_details/widgets/banner.dart';
import 'package:challenge/features/event_details/widgets/carousel.dart';
import 'package:challenge/features/event_details/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DSAppBar.logo(),
      body: SafeArea(
        bottom: false,
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<EventDetailsBloc, EventDetailsState>(
          builder: (context, state) {
            if (state.status == EventDetailsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == EventDetailsStatus.failure) {
              return Center(
                child: ErrorMessage(errorMessage: state.errorMessage),
              );
            }

            if (state.status == EventDetailsStatus.success &&
                state.currentEvent != null) {
              return _EventDetailsViewBody(state: state);
            }

            return const Center(child: Text('Nenhum evento disponível'));
          },
        ),
      ),
    );
  }
}

class _EventDetailsViewBody extends StatelessWidget {
  final EventDetailsState state;

  const _EventDetailsViewBody({required this.state});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Próximo Evento',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                EventBanner(
                  imageSrc: state.currentEvent!.imageSrc,
                  title: state.currentEvent!.title,
                  description: state.currentEvent!.description,
                  bookmarkAction: (value) {},
                  isBookmarked: state.currentEvent!.isBookmarked,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              spacing: 8,
              children: [
                DSListTile(
                  title: 'Onde',
                  subtitle: state.currentEvent!.location,
                  leading: Icons.location_on,
                ),
                DSListTile(
                  title: 'Quando',
                  subtitle: state.currentEvent!.date,
                  leading: Icons.event,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Carousel(
              title: 'Eventos anteriores',
              items: state.previousEvents
                  .map(
                    (event) =>
                        CarouselItem(title: event.title, image: event.imageSrc),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.errorMessage});
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
        const SizedBox(height: 16),
        Text(
          errorMessage ?? 'Erro desconhecido',
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<EventDetailsBloc>().add(const EventDetailsStarted());
          },
          child: const Text('Tentar novamente'),
        ),
      ],
    );
  }
}
