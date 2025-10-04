import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:challenge/bookmark/cubit/bookmark_cubit.dart';
import 'package:challenge/bookmark_list/bookmark_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meetup_repository/meetup_repository.dart';

class BookmarkListBloc extends Bloc<BookmarkListEvent, BookmarkListState> {
  late final StreamSubscription<Set<String>> _bookmarkCubitSubscription;
  final MeetupRepository meetupRepository;
  final BookmarkCubit bookmarkCubit;

  BookmarkListBloc({
    required this.meetupRepository,
    required this.bookmarkCubit,
  }) : super(const BookmarkListInitial()) {
    on<BookmarkListRequested>(_onBookmarkListRequested);
    _bookmarkCubitSubscription = bookmarkCubit.stream.listen((bookmarks) {
      add(const BookmarkListRefreshed());
    });
    on<BookmarkListRefreshed>(_onBookmarkListRefreshed);
  }

  Future<void> _onBookmarkListRequested(
    BookmarkListRequested event,
    Emitter<BookmarkListState> emit,
  ) async {
    emit(const BookmarkListLoading());

    try {
      final allMeetups = await meetupRepository.getAllMeetups();
      final bookmarkedIds = bookmarkCubit.state;

      final bookmarkedMeetups = allMeetups
          .where((meetup) => bookmarkedIds.contains(meetup.id))
          .toList();

      if (bookmarkedMeetups.isEmpty) {
        emit(const BookmarkListEmpty());
      } else {
        emit(BookmarkListLoaded(bookmarkedMeetups: bookmarkedMeetups));
      }
    } catch (error) {
      emit(
        BookmarkListFailure(
          errorMessage: 'Erro ao carregar favoritos: ${error.toString()}',
        ),
      );
    }
  }

  Future<void> _onBookmarkListRefreshed(
    BookmarkListRefreshed event,
    Emitter<BookmarkListState> emit,
  ) async {
    add(const BookmarkListRequested());
  }

  @override
  Future<void> close() {
    _bookmarkCubitSubscription.cancel();
    return super.close();
  }
}
