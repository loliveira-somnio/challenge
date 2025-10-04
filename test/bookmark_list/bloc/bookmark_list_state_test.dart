import 'package:challenge/bookmark_list/bookmark_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meetup_repository/meetup_repository.dart';

void main() {
  group(BookmarkListState, () {
    group(BookmarkListInitial, () {
      test('is a BookmarkListState', () {
        expect(const BookmarkListInitial(), isA<BookmarkListState>());
      });

      test('has correct props', () {
        expect(const BookmarkListInitial().props, equals([]));
      });

      test('supports equality', () {
        expect(
          const BookmarkListInitial(),
          equals(const BookmarkListInitial()),
        );
      });

      test('supports equality with different instances', () {
        const state1 = BookmarkListInitial();
        const state2 = BookmarkListInitial();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });
    });

    group(BookmarkListLoading, () {
      test('is a BookmarkListState', () {
        expect(const BookmarkListLoading(), isA<BookmarkListState>());
      });

      test('has correct props', () {
        expect(const BookmarkListLoading().props, equals([]));
      });

      test('supports equality', () {
        expect(
          const BookmarkListLoading(),
          equals(const BookmarkListLoading()),
        );
      });

      test('supports equality with different instances', () {
        const state1 = BookmarkListLoading();
        const state2 = BookmarkListLoading();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });
    });

    group(BookmarkListLoaded, () {
      final mockMeetups = [
        const Meetup(
          id: 'meetup-1',
          title: 'Flutter Meetup',
          description: 'Learn about Flutter',
          location: 'São Paulo',
          date: '2024-01-15',
          bannerImageSrc: 'https://example.com/image1.jpg',
        ),
        const Meetup(
          id: 'meetup-2',
          title: 'Dart Conference',
          description: 'Advanced Dart techniques',
          location: 'Rio de Janeiro',
          date: '2024-01-20',
          bannerImageSrc: 'https://example.com/image2.jpg',
        ),
      ];

      test('is a BookmarkListState', () {
        expect(
          BookmarkListLoaded(bookmarkedMeetups: mockMeetups),
          isA<BookmarkListState>(),
        );
      });

      test('has correct props', () {
        final state = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        expect(state.props, equals([mockMeetups]));
      });

      test('supports equality', () {
        final state1 = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        final state2 = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        expect(state1, equals(state2));
      });

      test('supports equality with different instances', () {
        final state1 = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        final state2 = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('is not equal when bookmarkedMeetups are different', () {
        final state1 = BookmarkListLoaded(bookmarkedMeetups: [mockMeetups[0]]);
        final state2 = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        expect(state1, isNot(equals(state2)));
      });

      test('is not equal when bookmarkedMeetups is empty', () {
        final state1 = BookmarkListLoaded(bookmarkedMeetups: []);
        final state2 = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
        expect(state1, isNot(equals(state2)));
      });

      group('copyWith', () {
        test('returns same instance when no parameters provided', () {
          final state = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
          final copiedState = state.copyWith();
          expect(copiedState, equals(state));
        });

        test('returns new instance with updated bookmarkedMeetups', () {
          final state = BookmarkListLoaded(bookmarkedMeetups: [mockMeetups[0]]);
          final copiedState = state.copyWith(bookmarkedMeetups: mockMeetups);
          expect(copiedState.bookmarkedMeetups, equals(mockMeetups));
          expect(copiedState, isNot(equals(state)));
        });

        test('returns new instance with empty bookmarkedMeetups', () {
          final state = BookmarkListLoaded(bookmarkedMeetups: mockMeetups);
          final copiedState = state.copyWith(bookmarkedMeetups: []);
          expect(copiedState.bookmarkedMeetups, equals([]));
          expect(copiedState, isNot(equals(state)));
        });
      });
    });

    group(BookmarkListEmpty, () {
      test('is a BookmarkListState', () {
        expect(const BookmarkListEmpty(), isA<BookmarkListState>());
      });

      test('has correct props', () {
        expect(const BookmarkListEmpty().props, equals([]));
      });

      test('supports equality', () {
        expect(const BookmarkListEmpty(), equals(const BookmarkListEmpty()));
      });

      test('supports equality with different instances', () {
        const state1 = BookmarkListEmpty();
        const state2 = BookmarkListEmpty();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });
    });

    group(BookmarkListFailure, () {
      const errorMessage = 'Network error';

      test('is a BookmarkListState', () {
        expect(
          const BookmarkListFailure(errorMessage: errorMessage),
          isA<BookmarkListState>(),
        );
      });

      test('has correct props', () {
        const state = BookmarkListFailure(errorMessage: errorMessage);
        expect(state.props, equals([errorMessage]));
      });

      test('supports equality', () {
        const state1 = BookmarkListFailure(errorMessage: errorMessage);
        const state2 = BookmarkListFailure(errorMessage: errorMessage);
        expect(state1, equals(state2));
      });

      test('supports equality with different instances', () {
        const state1 = BookmarkListFailure(errorMessage: errorMessage);
        const state2 = BookmarkListFailure(errorMessage: errorMessage);
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('is not equal when errorMessage is different', () {
        const state1 = BookmarkListFailure(errorMessage: 'Error 1');
        const state2 = BookmarkListFailure(errorMessage: 'Error 2');
        expect(state1, isNot(equals(state2)));
      });

      test('is not equal when errorMessage is empty', () {
        const state1 = BookmarkListFailure(errorMessage: '');
        const state2 = BookmarkListFailure(errorMessage: errorMessage);
        expect(state1, isNot(equals(state2)));
      });
    });

    group('equality between different state types', () {
      test('BookmarkListInitial is not equal to BookmarkListLoading', () {
        expect(
          const BookmarkListInitial(),
          isNot(equals(const BookmarkListLoading())),
        );
      });

      test('BookmarkListLoading is not equal to BookmarkListEmpty', () {
        expect(
          const BookmarkListLoading(),
          isNot(equals(const BookmarkListEmpty())),
        );
      });

      test('BookmarkListEmpty is not equal to BookmarkListLoaded', () {
        const loadedState = BookmarkListLoaded(bookmarkedMeetups: []);
        expect(const BookmarkListEmpty(), isNot(equals(loadedState)));
      });

      test('BookmarkListLoaded is not equal to BookmarkListFailure', () {
        const loadedState = BookmarkListLoaded(bookmarkedMeetups: []);
        const failureState = BookmarkListFailure(errorMessage: 'Error');
        expect(loadedState, isNot(equals(failureState)));
      });
    });
  });
}
