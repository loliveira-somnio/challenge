import 'package:equatable/equatable.dart';

abstract class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();

  @override
  List<Object?> get props => [];
}

class EventDetailsStarted extends EventDetailsEvent {
  const EventDetailsStarted();
}

class EventDetailsBookmarked extends EventDetailsEvent {
  final bool isBookmarked;

  const EventDetailsBookmarked({required this.isBookmarked});

  @override
  List<Object?> get props => [isBookmarked];
}
