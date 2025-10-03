import 'package:bloc_test/bloc_test.dart';
import 'package:challenge/data/data.dart';
import 'package:challenge/features/event/event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMeetupRepository extends Mock implements MeetupRepository {}

void main() {
  group(MeetupBloc, () {
    late _MockMeetupRepository mockMeetupRepository;
    late MeetupBloc meetupBloc;

    setUp(() {
      mockMeetupRepository = _MockMeetupRepository();
      meetupBloc = MeetupBloc(mockMeetupRepository);
    });

    tearDown(() {
      meetupBloc.close();
    });

    test('initial state is MeetupInitial', () {
      expect(meetupBloc.state, equals(const MeetupInitial()));
    });

    group('LatestMeetupRequested', () {
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

      blocTest<MeetupBloc, MeetupState>(
        'emits [MeetupLoading, LatestMeetupLoaded] when LatestMeetupRequested succeeds',
        build: () {
          when(
            () => mockMeetupRepository.getLatestMeetup(),
          ).thenAnswer((_) async => mockCurrentEvent);
          when(
            () => mockMeetupRepository.getPreviousMeetups(),
          ).thenAnswer((_) async => mockPreviousEvents);
          return meetupBloc;
        },
        act: (bloc) => bloc.add(const LatestMeetupRequested()),
        expect: () => [
          const MeetupLoading(),
          const LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          ),
        ],
        verify: (_) {
          verify(() => mockMeetupRepository.getLatestMeetup()).called(1);
          verify(() => mockMeetupRepository.getPreviousMeetups()).called(1);
        },
      );

      blocTest<MeetupBloc, MeetupState>(
        'emits [MeetupLoading, MeetupFailure] when getLatestMeetup fails',
        build: () {
          when(
            () => mockMeetupRepository.getLatestMeetup(),
          ).thenThrow(Exception('Failed to get latest meetup'));
          return meetupBloc;
        },
        act: (bloc) => bloc.add(const LatestMeetupRequested()),
        expect: () => [
          const MeetupLoading(),
          const MeetupFailure(
            errorMessage:
                'Erro ao carregar os eventos: Exception: Failed to get latest meetup',
          ),
        ],
        verify: (_) {
          verify(() => mockMeetupRepository.getLatestMeetup()).called(1);
          verifyNever(() => mockMeetupRepository.getPreviousMeetups());
        },
      );

      blocTest<MeetupBloc, MeetupState>(
        'emits [MeetupLoading, MeetupFailure] when getPreviousMeetups fails',
        build: () {
          when(
            () => mockMeetupRepository.getLatestMeetup(),
          ).thenAnswer((_) async => mockCurrentEvent);
          when(
            () => mockMeetupRepository.getPreviousMeetups(),
          ).thenThrow(Exception('Failed to get previous meetups'));
          return meetupBloc;
        },
        act: (bloc) => bloc.add(const LatestMeetupRequested()),
        expect: () => [
          const MeetupLoading(),
          const MeetupFailure(
            errorMessage:
                'Erro ao carregar os eventos: Exception: Failed to get previous meetups',
          ),
        ],
        verify: (_) {
          verify(() => mockMeetupRepository.getLatestMeetup()).called(1);
          verify(() => mockMeetupRepository.getPreviousMeetups()).called(1);
        },
      );

      blocTest<MeetupBloc, MeetupState>(
        'emits [MeetupLoading, MeetupFailure] when both repository calls fail',
        build: () {
          when(
            () => mockMeetupRepository.getLatestMeetup(),
          ).thenThrow(Exception('Failed to get latest meetup'));
          when(
            () => mockMeetupRepository.getPreviousMeetups(),
          ).thenThrow(Exception('Failed to get previous meetups'));
          return meetupBloc;
        },
        act: (bloc) => bloc.add(const LatestMeetupRequested()),
        expect: () => [
          const MeetupLoading(),
          const MeetupFailure(
            errorMessage:
                'Erro ao carregar os eventos: Exception: Failed to get latest meetup',
          ),
        ],
        verify: (_) {
          verify(() => mockMeetupRepository.getLatestMeetup()).called(1);
          verifyNever(() => mockMeetupRepository.getPreviousMeetups());
        },
      );
    });

    group('SpecificMeetupRequested', () {
      const mockEvent = MeetupData(
        id: 'specific-1',
        title: 'Specific Meetup',
        description: 'Specific meetup description',
        location: 'Porto Alegre',
        date: '2024-01-20',
      );

      blocTest<MeetupBloc, MeetupState>(
        'emits [SpecificMeetupLoaded] when SpecificMeetupRequested succeeds',
        build: () {
          when(
            () => mockMeetupRepository.getMeetupById('specific-1'),
          ).thenAnswer((_) async => mockEvent);
          return meetupBloc;
        },
        act: (bloc) =>
            bloc.add(const SpecificMeetupRequested(id: 'specific-1')),
        expect: () => [const SpecificMeetupLoaded(event: mockEvent)],
        verify: (_) {
          verify(
            () => mockMeetupRepository.getMeetupById('specific-1'),
          ).called(1);
        },
      );

      blocTest<MeetupBloc, MeetupState>(
        'emits [SpecificMeetupLoaded] when SpecificMeetupRequested with different id succeeds',
        build: () {
          const differentEvent = MeetupData(
            id: 'specific-2',
            title: 'Different Specific Meetup',
            description: 'Different specific meetup description',
            location: 'Curitiba',
            date: '2024-01-25',
          );
          when(
            () => mockMeetupRepository.getMeetupById('specific-2'),
          ).thenAnswer((_) async => differentEvent);
          return meetupBloc;
        },
        act: (bloc) =>
            bloc.add(const SpecificMeetupRequested(id: 'specific-2')),
        expect: () => [
          const SpecificMeetupLoaded(
            event: MeetupData(
              id: 'specific-2',
              title: 'Different Specific Meetup',
              description: 'Different specific meetup description',
              location: 'Curitiba',
              date: '2024-01-25',
            ),
          ),
        ],
        verify: (_) {
          verify(
            () => mockMeetupRepository.getMeetupById('specific-2'),
          ).called(1);
        },
      );
    });

    group('multiple events', () {
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
      ];

      const mockSpecificEvent = MeetupData(
        id: 'specific-1',
        title: 'Specific Meetup',
        description: 'Specific meetup description',
        location: 'Porto Alegre',
        date: '2024-01-20',
      );

      blocTest<MeetupBloc, MeetupState>(
        'handles multiple events in sequence',
        build: () {
          when(
            () => mockMeetupRepository.getLatestMeetup(),
          ).thenAnswer((_) async => mockCurrentEvent);
          when(
            () => mockMeetupRepository.getPreviousMeetups(),
          ).thenAnswer((_) async => mockPreviousEvents);
          when(
            () => mockMeetupRepository.getMeetupById('specific-1'),
          ).thenAnswer((_) async => mockSpecificEvent);
          return meetupBloc;
        },
        act: (bloc) {
          bloc.add(const LatestMeetupRequested());
          bloc.add(const SpecificMeetupRequested(id: 'specific-1'));
        },
        expect: () => [
          const MeetupLoading(),
          const LatestMeetupLoaded(
            currentEvent: mockCurrentEvent,
            previousEvents: mockPreviousEvents,
          ),
          const SpecificMeetupLoaded(event: mockSpecificEvent),
        ],
        verify: (_) {
          verify(() => mockMeetupRepository.getLatestMeetup()).called(1);
          verify(() => mockMeetupRepository.getPreviousMeetups()).called(1);
          verify(
            () => mockMeetupRepository.getMeetupById('specific-1'),
          ).called(1);
        },
      );
    });
  });
}
