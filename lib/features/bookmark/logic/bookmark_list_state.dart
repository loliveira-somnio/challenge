import 'package:challenge/data/model/meetup_data.dart';
import 'package:equatable/equatable.dart';

sealed class BookmarkListState extends Equatable {
  const BookmarkListState();

  @override
  List<Object?> get props => [];
}

class BookmarkListInitial extends BookmarkListState {
  const BookmarkListInitial();
}

class BookmarkListLoading extends BookmarkListState {
  const BookmarkListLoading();
}

class BookmarkListLoaded extends BookmarkListState {
  const BookmarkListLoaded({required this.bookmarkedMeetups});

  final List<MeetupData> bookmarkedMeetups;

  BookmarkListLoaded copyWith({List<MeetupData>? bookmarkedMeetups}) {
    return BookmarkListLoaded(
      bookmarkedMeetups: bookmarkedMeetups ?? this.bookmarkedMeetups,
    );
  }

  @override
  List<Object?> get props => [bookmarkedMeetups];
}

class BookmarkListEmpty extends BookmarkListState {
  const BookmarkListEmpty();
}

class BookmarkListFailure extends BookmarkListState {
  const BookmarkListFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
