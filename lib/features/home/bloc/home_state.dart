import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.currentEvent,
    this.previousEvents = const [],
    this.errorMessage,
  });

  final HomeStatus status;
  final EventData? currentEvent;
  final List<EventData> previousEvents;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    EventData? currentEvent,
    List<EventData>? previousEvents,
    String? errorMessage,
  }) {
    return HomeState(
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
