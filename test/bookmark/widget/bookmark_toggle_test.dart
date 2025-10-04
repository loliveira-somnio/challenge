import 'package:challenge/bookmark/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBookmarkCubit extends Mock implements BookmarkCubit {}

void main() {
  group(BookmarkToggle, () {
    late _MockBookmarkCubit mockBookmarkCubit;
    const meetupId = 'meetup-1';

    setUp(() {
      mockBookmarkCubit = _MockBookmarkCubit();

      // Setup default mock behavior
      when(
        () => mockBookmarkCubit.stream,
      ).thenAnswer((_) => Stream.value(<String>{}));
      when(() => mockBookmarkCubit.state).thenReturn(<String>{});
      when(() => mockBookmarkCubit.isBookmarked(any())).thenReturn(false);
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: BlocProvider<BookmarkCubit>.value(
          value: mockBookmarkCubit,
          child: const BookmarkToggle(meetupId: meetupId),
        ),
      );
    }

    testWidgets('renders BookmarkToggle', (tester) async {
      when(() => mockBookmarkCubit.state).thenReturn(<String>{});

      await tester.pumpWidget(createTestWidget());

      expect(find.byType(BookmarkToggle), findsOneWidget);
    });

    group('bookmark state display', () {
      testWidgets('shows bookmark_border icon when meetup is not bookmarked', (
        tester,
      ) async {
        when(() => mockBookmarkCubit.state).thenReturn(<String>{});
        when(() => mockBookmarkCubit.isBookmarked(meetupId)).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
        expect(find.byIcon(Icons.bookmark), findsNothing);
      });

      testWidgets('shows bookmark icon when meetup is bookmarked', (
        tester,
      ) async {
        when(() => mockBookmarkCubit.state).thenReturn({meetupId});
        when(() => mockBookmarkCubit.isBookmarked(meetupId)).thenReturn(true);

        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.bookmark), findsOneWidget);
        expect(find.byIcon(Icons.bookmark_border), findsNothing);
      });
    });

    group('interactions', () {
      testWidgets('calls toggleBookmark when button is tapped', (tester) async {
        when(() => mockBookmarkCubit.state).thenReturn(<String>{});
        when(() => mockBookmarkCubit.isBookmarked(meetupId)).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        final button = find.byType(IconButton);
        expect(button, findsOneWidget);

        await tester.tap(button);
        await tester.pump();

        verify(() => mockBookmarkCubit.toggleBookmark(meetupId)).called(1);
      });
    });

    group('state updates', () {
      testWidgets('updates icon when bookmark state changes', (tester) async {
        when(() => mockBookmarkCubit.state).thenReturn(<String>{});
        when(() => mockBookmarkCubit.isBookmarked(meetupId)).thenReturn(false);

        await tester.pumpWidget(createTestWidget());

        expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
        expect(find.byIcon(Icons.bookmark), findsNothing);

        // Simulate state change
        when(() => mockBookmarkCubit.state).thenReturn({meetupId});
        when(() => mockBookmarkCubit.isBookmarked(meetupId)).thenReturn(true);

        await tester.pump();

        expect(find.byIcon(Icons.bookmark), findsOneWidget);
        expect(find.byIcon(Icons.bookmark_border), findsNothing);
      });
    });

    group('edge cases', () {
      testWidgets('handles empty meetup id', (tester) async {
        when(() => mockBookmarkCubit.state).thenReturn(<String>{});
        when(() => mockBookmarkCubit.isBookmarked('')).thenReturn(false);

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<BookmarkCubit>.value(
              value: mockBookmarkCubit,
              child: const BookmarkToggle(meetupId: ''),
            ),
          ),
        );

        expect(find.byType(BookmarkToggle), findsOneWidget);
        expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
      });
    });
  });
}
