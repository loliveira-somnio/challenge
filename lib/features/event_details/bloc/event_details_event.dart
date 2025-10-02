import 'package:equatable/equatable.dart';

abstract class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();

  @override
  List<Object?> get props => [];
}

class EventDetailsInitialized extends EventDetailsEvent {
  const EventDetailsInitialized();
}

class EventDetailsEventDetailsRequested extends EventDetailsEvent {
  const EventDetailsEventDetailsRequested();
}

class EventDetailsPreviousEventsRequested extends EventDetailsEvent {
  const EventDetailsPreviousEventsRequested();
}
