import 'package:challenge/data/data.dart';
import 'package:challenge/features/event/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(MeetupState, () {
    group(MeetupInitial, () {
      test('is a MeetupState', () {
        expect(const MeetupInitial(), isA<MeetupState>());
      });

      test('has correct props', () {
        expect(const MeetupInitial().props, equals([]));
      });

      test('supports equality', () {
        expect(const MeetupInitial(), equals(const MeetupInitial()));
      });
    });

    group(MeetupLoading, () {
      test('is a MeetupState', () {
        expect(const MeetupLoading(), isA<MeetupState>());
      });

      test('has correct props', () {
        expect(const MeetupLoading().props, equals([]));
      });

      test('supports equality', () {
        expect(const MeetupLoading(), equals(const MeetupLoading()));
      });
    });

    group(LatestMeetupLoaded, () {
      const mockCurrentEvent = MeetupData(
        id: 'current-1',
        title: 'Current Meetup',
        description: 'Current meetup description',
        location: 'São Paulo',
        date: '2024-01-15',
      );

      const mockPreviousEvents = [
        MeetupData(
          id: 'prev-1',
          title: 'Previous Meetup 1',
          description: 'Previous meetup 1 description',
          location: 'Rio de Janeiro',
          date: '2023-12-15',
        ),
        MeetupData(
          id: 'prev-2',
          title: 'Previous Meetup 2',
          description: 'Previous meetup 2 description',
          location: 'Belo Horizonte',
          date: '2023-11-15',
        ),
      ];

      test('is a MeetupState', () {
        expect(
          const LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          ),
          isA<MeetupState>(),
        );
      });

      test('has correct props', () {
        const state = LatestMeetupLoaded(
          currentEvent: mockCurrentEvent,
          previousEvents: mockPreviousEvents,
        );

        expect(state.props, equals([mockCurrentEvent, mockPreviousEvents]));
      });

      test('supports equality', () {
        const state1 = LatestMeetupLoaded(
          currentEvent: mockCurrentEvent,
          previousEvents: mockPreviousEvents,
        );

        const state2 = LatestMeetupLoaded(
          currentEvent: mockCurrentEvent,
          previousEvents: mockPreviousEvents,
        );

        expect(state1, equals(state2));
      });

      test('different current events are not equal', () {
        const differentCurrentEvent = MeetupData(
          id: 'different-current',
          title: 'Different Current Meetup',
          description: 'Different current meetup description',
          location: 'Brasília',
          date: '2024-02-15',
        );

        const state1 = LatestMeetupLoaded(
          currentEvent: mockCurrentEvent,
          previousEvents: mockPreviousEvents,
        );

        const state2 = LatestMeetupLoaded(
          currentEvent: differentCurrentEvent,
          previousEvents: mockPreviousEvents,
        );

        expect(state1, isNot(equals(state2)));
      });

      test('different previous events are not equal', () {
        const differentPreviousEvents = [
          MeetupData(
            id: 'different-prev',
            title: 'Different Previous Meetup',
            description: 'Different previous meetup description',
            location: 'Salvador',
            date: '2023-10-15',
          ),
        ];

        const state1 = LatestMeetupLoaded(
          currentEvent: mockCurrentEvent,
          previousEvents: mockPreviousEvents,
        );

        const state2 = LatestMeetupLoaded(
          currentEvent: mockCurrentEvent,
          previousEvents: differentPreviousEvents,
        );

        expect(state1, isNot(equals(state2)));
      });

      group('copyWith', () {
        test('returns new instance with updated currentEvent', () {
          const newCurrentEvent = MeetupData(
            id: 'new-current',
            title: 'New Current Meetup',
            description: 'New current meetup description',
            location: 'Fortaleza',
            date: '2024-03-15',
          );

          const originalState = LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          );

          final updatedState = originalState.copyWith(
            currentEvent: newCurrentEvent,
          );

          expect(updatedState.currentEvent, equals(newCurrentEvent));
          expect(updatedState.previousEvents, equals(mockPreviousEvents));
        });

        test('returns new instance with updated previousEvents', () {
          const newPreviousEvents = [
            MeetupData(
              id: 'new-prev',
              title: 'New Previous Meetup',
              description: 'New previous meetup description',
              location: 'Recife',
              date: '2023-09-15',
            ),
          ];

          const originalState = LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          );

          final updatedState = originalState.copyWith(
            previousEvents: newPreviousEvents,
          );

          expect(updatedState.currentEvent, equals(mockCurrentEvent));
          expect(updatedState.previousEvents, equals(newPreviousEvents));
        });

        test('returns new instance with both updated', () {
          const newCurrentEvent = MeetupData(
            id: 'new-current',
            title: 'New Current Meetup',
            description: 'New current meetup description',
            location: 'Fortaleza',
            date: '2024-03-15',
          );

          const newPreviousEvents = [
            MeetupData(
              id: 'new-prev',
              title: 'New Previous Meetup',
              description: 'New previous meetup description',
              location: 'Recife',
              date: '2023-09-15',
            ),
          ];

          const originalState = LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          );

          final updatedState = originalState.copyWith(
            currentEvent: newCurrentEvent,
            previousEvents: newPreviousEvents,
          );

          expect(updatedState.currentEvent, equals(newCurrentEvent));
          expect(updatedState.previousEvents, equals(newPreviousEvents));
        });

        test('returns same instance when no parameters provided', () {
          const originalState = LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          );

          final updatedState = originalState.copyWith();

          expect(updatedState.currentEvent, equals(mockCurrentEvent));
          expect(updatedState.previousEvents, equals(mockPreviousEvents));
        });
      });
    });

    group(SpecificMeetupLoaded, () {
      const mockEvent = MeetupData(
        id: 'specific-1',
        title: 'Specific Meetup',
        description: 'Specific meetup description',
        location: 'Porto Alegre',
        date: '2024-01-20',
      );

      test('is a MeetupState', () {
        expect(
          const SpecificMeetupLoaded(event: mockEvent),
          isA<MeetupState>(),
        );
      });

      test('has correct props', () {
        const state = SpecificMeetupLoaded(event: mockEvent);

        expect(state.props, equals([mockEvent]));
      });

      test('supports equality', () {
        const state1 = SpecificMeetupLoaded(event: mockEvent);
        const state2 = SpecificMeetupLoaded(event: mockEvent);

        expect(state1, equals(state2));
      });

      test('different events are not equal', () {
        const differentEvent = MeetupData(
          id: 'different-specific',
          title: 'Different Specific Meetup',
          description: 'Different specific meetup description',
          location: 'Curitiba',
          date: '2024-01-25',
        );

        const state1 = SpecificMeetupLoaded(event: mockEvent);
        const state2 = SpecificMeetupLoaded(event: differentEvent);

        expect(state1, isNot(equals(state2)));
      });
    });

    group(MeetupFailure, () {
      const mockErrorMessage = 'Test error message';

      test('is a MeetupState', () {
        expect(
          const MeetupFailure(errorMessage: mockErrorMessage),
          isA<MeetupState>(),
        );
      });

      test('has correct props', () {
        const state = MeetupFailure(errorMessage: mockErrorMessage);

        expect(state.props, equals([mockErrorMessage]));
      });

      test('supports equality', () {
        const state1 = MeetupFailure(errorMessage: mockErrorMessage);
        const state2 = MeetupFailure(errorMessage: mockErrorMessage);

        expect(state1, equals(state2));
      });

      test('different error messages are not equal', () {
        const differentErrorMessage = 'Different error message';

        const state1 = MeetupFailure(errorMessage: mockErrorMessage);
        const state2 = MeetupFailure(errorMessage: differentErrorMessage);

        expect(state1, isNot(equals(state2)));
      });
    });
  });
}
