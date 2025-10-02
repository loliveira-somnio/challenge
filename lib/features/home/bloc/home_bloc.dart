import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitialized>(_onHomeInitialized);
    on<HomeEventDetailsRequested>(_onHomeEventDetailsRequested);
    on<HomePreviousEventsRequested>(_onHomePreviousEventsRequested);
  }

  Future<void> _onHomeInitialized(
    HomeInitialized event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

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
          status: HomeStatus.success,
          currentEvent: currentEvent,
          previousEvents: previousEvents,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'Erro ao carregar os eventos: ${error.toString()}',
        ),
      );
    }
  }

  Future<void> _onHomeEventDetailsRequested(
    HomeEventDetailsRequested event,
    Emitter<HomeState> emit,
  ) async {
    // Handle event details request
    // This could navigate to event details page or show more info
  }

  Future<void> _onHomePreviousEventsRequested(
    HomePreviousEventsRequested event,
    Emitter<HomeState> emit,
  ) async {
    // Handle previous events request
    // This could refresh the previous events list
  }
}
