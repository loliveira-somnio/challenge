import 'package:meetup_repository/meetup_repository.dart';
import 'package:challenge/meetup/meetup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetupBloc extends Bloc<MeetupEvent, MeetupState> {
  final MeetupRepository meetupRepository;

  MeetupBloc(this.meetupRepository) : super(const MeetupInitial()) {
    on<LatestMeetupRequested>(_onLatestMeetupRequested);
    on<SpecificMeetupRequested>(_onSpecificMeetupRequested);
  }

  Future<void> _onLatestMeetupRequested(
    LatestMeetupRequested event,
    Emitter<MeetupState> emit,
  ) async {
    emit(const MeetupLoading());

    try {
      final currentEvent = await meetupRepository.getLatestMeetup();
      final previousEvents = await meetupRepository.getPreviousMeetups();

      emit(
        LatestMeetupLoaded(
          currentEvent: currentEvent,
          previousEvents: previousEvents,
        ),
      );
    } catch (error) {
      emit(
        MeetupFailure(
          errorMessage: 'Erro ao carregar os eventos: ${error.toString()}',
        ),
      );
    }
  }

  Future<void> _onSpecificMeetupRequested(
    SpecificMeetupRequested event,
    Emitter<MeetupState> emit,
  ) async {
    final eventId = await meetupRepository.getMeetupById(event.id);
    emit(SpecificMeetupLoaded(event: eventId));
    // Handle event details request
    // This could navigate to event details page or show more info
  }
}
