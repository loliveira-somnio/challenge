import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_details_event.dart';
import 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc() : super(const EventDetailsState()) {
    on<EventDetailsStarted>(_onEventDetailsInitialized);
    on<EventDetailsBookmarked>(_onEventDetailsEventDetailsRequested);
  }

  Future<void> _onEventDetailsInitialized(
    EventDetailsStarted event,
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

      // Mocked previous events data
      final previousEvents = [
        const EventData(
          id: '2',
          title: 'Frontend Conference',
          description:
              'Um evento focado em tecnologias de frontend e melhores práticas de UI/UX.',
          imageSrc: 'https://placehold.co/96x96.png',
          location: 'Curitiba, PR',
          date: '15 de setembro de 2025',
        ),
        const EventData(
          id: '3',
          title: 'Backend Summit',
          description:
              'Discussões profundas sobre arquitetura de sistemas e APIs modernas.',
          imageSrc: 'https://placehold.co/96x96.png',
          location: 'Porto Alegre, RS',
          date: '10 de agosto de 2025',
        ),
        const EventData(
          id: '4',
          title: 'Mobile Dev Day',
          description:
              'Tudo sobre desenvolvimento mobile, frameworks e tendências.',
          imageSrc: 'https://placehold.co/96x96.png',
          location: 'Recife, PE',
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
    EventDetailsBookmarked event,
    Emitter<EventDetailsState> emit,
  ) async {
    // Handle event details request
    // This could navigate to event details page or show more info
  }
}
