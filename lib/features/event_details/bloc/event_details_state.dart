import 'package:equatable/equatable.dart';

enum EventDetailsStatus { initial, loading, success, failure }

class EventDetailsState extends Equatable {
  const EventDetailsState({
    this.status = EventDetailsStatus.initial,
    this.currentEvent,
    this.previousEvents = const [],
    this.errorMessage,
  });

  final EventDetailsStatus status;
  final EventData? currentEvent;
  final List<EventData> previousEvents;
  final String? errorMessage;

  EventDetailsState copyWith({
    EventDetailsStatus? status,
    EventData? currentEvent,
    List<EventData>? previousEvents,
    String? errorMessage,
  }) {
    return EventDetailsState(
      status: status ?? this.status,
      currentEvent: currentEvent ?? this.currentEvent,
      previousEvents: previousEvents ?? this.previousEvents,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    currentEvent,
    previousEvents,
    errorMessage,
  ];
}

class EventData extends Equatable {
  const EventData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageSrc,
    required this.location,
    required this.date,
    this.isBookmarked = false,
  });

  final String id;
  final String title;
  final String description;
  final String imageSrc;
  final String location;
  final String date;
  final bool isBookmarked;

  @override
  List<Object?> get props => [id, title, description, imageSrc, location, date];
}
