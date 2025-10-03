import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/data/data.dart';
import 'package:challenge/features/bookmark_list/bookmark_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMeetupRepository extends Mock implements MeetupRepository {}

class _MockBookmarkCubit extends Mock implements BookmarkCubit {}

void main() {
  group(BookmarkListBloc, () {
    late _MockMeetupRepository mockMeetupRepository;
    late _MockBookmarkCubit mockBookmarkCubit;
    late BookmarkListBloc bookmarkListBloc;

    setUp(() {
      mockMeetupRepository = _MockMeetupRepository();
      mockBookmarkCubit = _MockBookmarkCubit();

      // Setup default mock behavior
      when(
        () => mockBookmarkCubit.stream,
      ).thenAnswer((_) => Stream.value(<String>{}));
      when(() => mockBookmarkCubit.state).thenReturn(<String>{});

      bookmarkListBloc = BookmarkListBloc(
        meetupRepository: mockMeetupRepository,
        bookmarkCubit: mockBookmarkCubit,
      );
    });

    tearDown(() {
      bookmarkListBloc.close();
    });

    test('initial state is BookmarkListInitial', () {
      expect(bookmarkListBloc.state, equals(const BookmarkListInitial()));
    });

    group('BookmarkListRequested', () {
      final mockMeetups = [
        const MeetupData(
          id: 'meetup-1',
          title: 'Flutter Meetup',
          description: 'Learn about Flutter',
          location: 'São Paulo',
          date: '2024-01-15',
          bannerImageSrc: 'https://example.com/image1.jpg',
        ),
        const MeetupData(
          id: 'meetup-2',
          title: 'Dart Conference',
          description: 'Advanced Dart techniques',
          location: 'Rio de Janeiro',
          date: '2024-01-20',
          bannerImageSrc: 'https://example.com/image2.jpg',
        ),
        const MeetupData(
          id: 'meetup-3',
          title: 'Mobile Development',
          description: 'Cross-platform development',
          location: 'Belo Horizonte',
          date: '2024-01-25',
          bannerImageSrc: 'https://example.com/image3.jpg',
        ),
      ];

      blocTest<BookmarkListBloc, BookmarkListState>(
        'emits [loading, loaded] when repository returns meetups and some are bookmarked',
        build: () {
          when(
            () => mockMeetupRepository.getAllMeetups(),
          ).thenAnswer((_) async => mockMeetups);
          when(
            () => mockBookmarkCubit.state,
          ).thenReturn({'meetup-1', 'meetup-3'});
          return bookmarkListBloc;
        },
        act: (bloc) => bloc.add(const BookmarkListRequested()),
        expect: () => [
          const BookmarkListLoading(),
          BookmarkListLoaded(
            bookmarkedMeetups: [mockMeetups[0], mockMeetups[2]],
          ),
        ],
      );

      blocTest<BookmarkListBloc, BookmarkListState>(
        'emits [loading, empty] when repository returns meetups but none are bookmarked',
        build: () {
          when(
            () => mockMeetupRepository.getAllMeetups(),
          ).thenAnswer((_) async => mockMeetups);
          when(() => mockBookmarkCubit.state).thenReturn(<String>{});
          return bookmarkListBloc;
        },
        act: (bloc) => bloc.add(const BookmarkListRequested()),
        expect: () => [const BookmarkListLoading(), const BookmarkListEmpty()],
      );

      blocTest<BookmarkListBloc, BookmarkListState>(
        'emits [loading, empty] when repository returns empty list',
        build: () {
          when(
            () => mockMeetupRepository.getAllMeetups(),
          ).thenAnswer((_) async => <MeetupData>[]);
          when(() => mockBookmarkCubit.state).thenReturn({'meetup-1'});
          return bookmarkListBloc;
        },
        act: (bloc) => bloc.add(const BookmarkListRequested()),
        expect: () => [const BookmarkListLoading(), const BookmarkListEmpty()],
      );

      blocTest<BookmarkListBloc, BookmarkListState>(
        'emits [loading, failure] when repository throws exception',
        build: () {
          when(
            () => mockMeetupRepository.getAllMeetups(),
          ).thenThrow(Exception('Network error'));
          return bookmarkListBloc;
        },
        act: (bloc) => bloc.add(const BookmarkListRequested()),
        expect: () => [
          const BookmarkListLoading(),
          const BookmarkListFailure(
            errorMessage:
                'Erro ao carregar favoritos: Exception: Network error',
          ),
        ],
      );

      blocTest<BookmarkListBloc, BookmarkListState>(
        'filters meetups correctly when some bookmarked meetups are not in repository data',
        build: () {
          when(
            () => mockMeetupRepository.getAllMeetups(),
          ).thenAnswer((_) async => [mockMeetups[0], mockMeetups[1]]);
          when(
            () => mockBookmarkCubit.state,
          ).thenReturn({'meetup-1', 'meetup-3'});
          return bookmarkListBloc;
        },
        act: (bloc) => bloc.add(const BookmarkListRequested()),
        expect: () => [
          const BookmarkListLoading(),
          BookmarkListLoaded(bookmarkedMeetups: [mockMeetups[0]]),
        ],
      );
    });

    group('BookmarkListRefreshed', () {
      blocTest<BookmarkListBloc, BookmarkListState>(
        'triggers BookmarkListRequested when BookmarkListRefreshed is added',
        build: () {
          when(
            () => mockMeetupRepository.getAllMeetups(),
          ).thenAnswer((_) async => <MeetupData>[]);
          when(() => mockBookmarkCubit.state).thenReturn(<String>{});
          return bookmarkListBloc;
        },
        act: (bloc) => bloc.add(const BookmarkListRefreshed()),
        expect: () => [const BookmarkListLoading(), const BookmarkListEmpty()],
      );
    });
  });
}
