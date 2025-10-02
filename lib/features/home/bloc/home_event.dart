import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitialized extends HomeEvent {
  const HomeInitialized();
}

class HomeEventDetailsRequested extends HomeEvent {
  const HomeEventDetailsRequested();
}

class HomePreviousEventsRequested extends HomeEvent {
  const HomePreviousEventsRequested();
}
