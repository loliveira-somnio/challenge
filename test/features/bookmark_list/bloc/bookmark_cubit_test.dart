import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/features/bookmark_list/bookmark_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(BookmarkCubit, () {
    late BookmarkCubit bookmarkCubit;

    setUp(() {
      bookmarkCubit = BookmarkCubit();
    });

    tearDown(() {
      bookmarkCubit.close();
    });

    test('initial state is empty set', () {
      expect(bookmarkCubit.state, equals(<String>{}));
    });

    group('toggleBookmark', () {
      const meetupId = 'meetup-1';

      blocTest<BookmarkCubit, Set<String>>(
        'adds meetup to bookmarks when not bookmarked',
        build: () => BookmarkCubit(),
        act: (cubit) => cubit.toggleBookmark(meetupId),
        expect: () => [
          {meetupId},
        ],
      );

      blocTest<BookmarkCubit, Set<String>>(
        'removes meetup from bookmarks when already bookmarked',
        build: () => BookmarkCubit(),
        seed: () => {meetupId},
        act: (cubit) => cubit.toggleBookmark(meetupId),
        expect: () => [<String>{}],
      );

      blocTest<BookmarkCubit, Set<String>>(
        'adds multiple meetups to bookmarks',
        build: () => BookmarkCubit(),
        act: (cubit) {
          cubit.toggleBookmark('meetup-1');
          cubit.toggleBookmark('meetup-2');
          cubit.toggleBookmark('meetup-3');
        },
        expect: () => [
          {'meetup-1'},
          {'meetup-1', 'meetup-2'},
          {'meetup-1', 'meetup-2', 'meetup-3'},
        ],
      );

      blocTest<BookmarkCubit, Set<String>>(
        'removes specific meetup while keeping others',
        build: () => BookmarkCubit(),
        seed: () => {'meetup-1', 'meetup-2', 'meetup-3'},
        act: (cubit) => cubit.toggleBookmark('meetup-2'),
        expect: () => [
          {'meetup-1', 'meetup-3'},
        ],
      );

      blocTest<BookmarkCubit, Set<String>>(
        'handles empty meetup id',
        build: () => BookmarkCubit(),
        act: (cubit) => cubit.toggleBookmark(''),
        expect: () => [
          {''},
        ],
      );
    });

    group('isBookmarked', () {
      const meetupId = 'meetup-1';

      test('returns false when meetup is not bookmarked', () {
        expect(bookmarkCubit.isBookmarked(meetupId), isFalse);
      });

      test('returns true when meetup is bookmarked', () {
        bookmarkCubit.toggleBookmark(meetupId);
        expect(bookmarkCubit.isBookmarked(meetupId), isTrue);
      });

      test('returns false after meetup is removed from bookmarks', () {
        bookmarkCubit.toggleBookmark(meetupId);
        bookmarkCubit.toggleBookmark(meetupId);
        expect(bookmarkCubit.isBookmarked(meetupId), isFalse);
      });

      test('handles empty meetup id', () {
        expect(bookmarkCubit.isBookmarked(''), isFalse);
        bookmarkCubit.toggleBookmark('');
        expect(bookmarkCubit.isBookmarked(''), isTrue);
      });
    });

    group('toString', () {
      test('returns correct string representation with empty bookmarks', () {
        expect(
          bookmarkCubit.toString(),
          equals('BookmarkCubit(bookmarks: {})'),
        );
      });

      test('returns correct string representation with bookmarks', () {
        bookmarkCubit.toggleBookmark('meetup-1');
        bookmarkCubit.toggleBookmark('meetup-2');
        expect(
          bookmarkCubit.toString(),
          equals('BookmarkCubit(bookmarks: {meetup-1, meetup-2})'),
        );
      });
    });
  });
}
