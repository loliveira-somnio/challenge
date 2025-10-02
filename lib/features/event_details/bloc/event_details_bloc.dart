import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_details_event.dart';
import 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc() : super(const EventDetailsState()) {
    on<EventDetailsInitialized>(_onEventDetailsInitialized);
    on<EventDetailsEventDetailsRequested>(_onEventDetailsEventDetailsRequested);
    on<EventDetailsPreviousEventsRequested>(
      _onEventDetailsPreviousEventsRequested,
    );
  }

  Future<void> _onEventDetailsInitialized(
    EventDetailsInitialized event,
    Emitter<EventDetailsState> emit,
  ) async {
    emit(state.copyWith(status: EventDetailsStatus.loading));

    try {
      // Simulate loading current event and previous events
      await Future.delayed(const Duration(milliseconds: 500));

      final currentEvent = const EventData(
        id: '1',
        title: 'Tech Meetup',
        description:
            'Prepare-se para uma manhã inteira dedicada à inovação, conhecimento e networking! O Tech Meetup é o ponto de encontro para apaixonados por tecnologia, profissionais do setor e estudantes que desejam se atualizar sobre as principais tendências do mercado além de ser uma ótima oportunidade para trocar experiências e criar conexões valiosas com a comunidade',
        imageSrc: 'https://placehold.co/380x205.png',
        location: 'São Paulo, SP',
        date: '20 de outubro de 2025',
      );

      final previousEvents = const [
        EventData(
          id: '2',
          title: 'Evento 1',
          description: 'Descrição do evento anterior 1',
          imageSrc: 'https://placehold.co/96x96.png',
          location: 'São Paulo, SP',
          date: '15 de setembro de 2025',
        ),
        EventData(
          id: '3',
          title: 'Evento 2',
          description: 'Descrição do evento anterior 2',
          imageSrc: 'https://placehold.co/96x96.png',
          location: 'Rio de Janeiro, RJ',
          date: '10 de agosto de 2025',
        ),
        EventData(
          id: '4',
          title: 'Evento 3',
          description: 'Descrição do evento anterior 3',
          imageSrc: 'https://placehold.co/96x96.png',
          location: 'Belo Horizonte, MG',
          date: '5 de julho de 2025',
        ),
      ];

      emit(
        state.copyWith(
          status: EventDetailsStatus.success,
          currentEvent: currentEvent,
          previousEvents: previousEvents,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: EventDetailsStatus.failure,
          errorMessage: 'Erro ao carregar os eventos: ${error.toString()}',
        ),
      );
    }
  }

  Future<void> _onEventDetailsEventDetailsRequested(
    EventDetailsEventDetailsRequested event,
    Emitter<EventDetailsState> emit,
  ) async {
    // Handle event details request
    // This could navigate to event details page or show more info
  }

  Future<void> _onEventDetailsPreviousEventsRequested(
    EventDetailsPreviousEventsRequested event,
    Emitter<EventDetailsState> emit,
  ) async {
    // Handle previous events request
    // This could refresh the previous events list
  }
}
