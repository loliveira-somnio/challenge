import 'package:equatable/equatable.dart';

abstract class MeetupEvent extends Equatable {
  const MeetupEvent();

  @override
  List<Object?> get props => [];
}

class LatestMeetupRequested extends MeetupEvent {
  const LatestMeetupRequested();
}

class SpecificMeetupRequested extends MeetupEvent {
  final String id;

  const SpecificMeetupRequested({required this.id});

  @override
  List<Object?> get props => [id];
}
