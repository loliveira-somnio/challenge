import 'package:bloc/bloc.dart';

class BookmarkCubit extends Cubit<Set<String>> {
  BookmarkCubit() : super({});

  void toggleBookmark(String meetupId) {
    if (state.contains(meetupId)) {
      final bookmarks = state..remove(meetupId);
      emit({...bookmarks});
    } else {
      emit({...state, meetupId});
    }
  }

  bool isBookmarked(String meetupId) {
    return state.contains(meetupId);
  }

  @override
  String toString() {
    return 'BookmarkCubit(bookmarks: $state)';
  }
}
