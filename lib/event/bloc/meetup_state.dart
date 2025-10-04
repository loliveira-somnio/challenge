import 'package:equatable/equatable.dart';
import 'package:meetup_repository/meetup_repository.dart';

sealed class MeetupState extends Equatable {
  const MeetupState();

  @override
  List<Object?> get props => [];
}

class MeetupInitial extends MeetupState {
  const MeetupInitial();
}

class MeetupLoading extends MeetupState {
  const MeetupLoading();
}

class LatestMeetupLoaded extends MeetupState {
  const LatestMeetupLoaded({
    required this.currentEvent,
    required this.previousEvents,
  });

  final Meetup currentEvent;
  final List<Meetup> previousEvents;

  LatestMeetupLoaded copyWith({
    Meetup? currentEvent,
    List<Meetup>? previousEvents,
  }) {
    return LatestMeetupLoaded(
      currentEvent: currentEvent ?? this.currentEvent,
      previousEvents: previousEvents ?? this.previousEvents,
    );
  }

  @override
  List<Object?> get props => [currentEvent, previousEvents];
}

class SpecificMeetupLoaded extends MeetupState {
  const SpecificMeetupLoaded({required this.event});

  final Meetup event;

  @override
  List<Object?> get props => [event];
}

class MeetupFailure extends MeetupState {
  const MeetupFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
