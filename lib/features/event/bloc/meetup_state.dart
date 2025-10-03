import 'package:challenge/data/model/meetup_data.dart';
import 'package:equatable/equatable.dart';

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

  final MeetupData currentEvent;
  final List<MeetupData> previousEvents;

  LatestMeetupLoaded copyWith({
    MeetupData? currentEvent,
    List<MeetupData>? previousEvents,
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

  final MeetupData event;

  @override
  List<Object?> get props => [event];
}

class MeetupFailure extends MeetupState {
  const MeetupFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
