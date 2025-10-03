import 'package:equatable/equatable.dart';

abstract class BookmarkListEvent extends Equatable {
  const BookmarkListEvent();

  @override
  List<Object?> get props => [];
}

class BookmarkListRequested extends BookmarkListEvent {
  const BookmarkListRequested();
}

class BookmarkListRefreshed extends BookmarkListEvent {
  const BookmarkListRefreshed();
}
