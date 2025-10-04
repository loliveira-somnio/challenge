import 'package:meetup_client/meetup_client.dart';
import 'package:meetup_repository/meetup_repository.dart';
import 'package:test/test.dart';

// Mock class for MeetupService
class MockMeetupService implements MeetupClient {
  @override
  Future<List<MeetupData>> loadMeetups() async {
    return _loadMeetupsResult;
  }

  @override
  Future<MeetupData> getLatestMeetup() async {
    return _getLatestMeetupResult;
  }

  @override
  Future<MeetupData> getMeetupById(String meetupId) async {
    return _getMeetupByIdResult;
  }

  @override
  Future<List<MeetupData>> getPreviousMeetups() async {
    return _getPreviousMeetupsResult;
  }

  @override
  Future<List<MeetupData>> getAllMeetups() async {
    return _getAllMeetupsResult;
  }

  // Control variables for test scenarios
  List<MeetupData> _loadMeetupsResult = [];
  late MeetupData _getLatestMeetupResult;
  late MeetupData _getMeetupByIdResult;
  List<MeetupData> _getPreviousMeetupsResult = [];
  List<MeetupData> _getAllMeetupsResult = [];

  // Setters for controlling mock behavior
  void setLoadMeetupsResult(List<MeetupData> result) {
    _loadMeetupsResult = result;
  }

  void setGetLatestMeetupResult(MeetupData result) {
    _getLatestMeetupResult = result;
  }

  void setGetMeetupByIdResult(MeetupData result) {
    _getMeetupByIdResult = result;
  }

  void setGetPreviousMeetupsResult(List<MeetupData> result) {
    _getPreviousMeetupsResult = result;
  }

  void setGetAllMeetupsResult(List<MeetupData> result) {
    _getAllMeetupsResult = result;
  }
}

void main() {
  group('MeetupRepositoryImpl', () {
    late MockMeetupService mockMeetupService;
    late MeetupRepository meetupRepository;

    const testMeetupData = MeetupData(
      id: '1',
      title: 'Test Meetup',
      description: 'Test description',
      location: 'Test Location',
      date: '2025-01-01',
    );

    const testMeetupData2 = MeetupData(
      id: '2',
      title: 'Test Meetup 2',
      description: 'Test description 2',
      location: 'Test Location 2',
      date: '2025-01-02',
      isBookmarked: true,
    );

    setUp(() {
      mockMeetupService = MockMeetupService();
      meetupRepository = MeetupRepository(mockMeetupService);
    });

    group('getLatestMeetup', () {
      test('delegates to MeetupService and returns result', () async {
        // Arrange
        mockMeetupService.setGetLatestMeetupResult(testMeetupData);

        // Act
        final result = await meetupRepository.getLatestMeetup();

        // Assert
        expect(result, equals(testMeetupData));
        expect(result.id, '1');
        expect(result.title, 'Test Meetup');
      });

      test('returns different meetup data correctly', () async {
        // Arrange
        mockMeetupService.setGetLatestMeetupResult(testMeetupData2);

        // Act
        final result = await meetupRepository.getLatestMeetup();

        // Assert
        expect(result, equals(testMeetupData2));
        expect(result.id, '2');
        expect(result.title, 'Test Meetup 2');
        expect(result.isBookmarked, true);
      });
    });

    group('getMeetupById', () {
      test(
        'delegates to MeetupService with correct ID and returns result',
        () async {
          // Arrange
          const meetupId = '123';
          mockMeetupService.setGetMeetupByIdResult(testMeetupData);

          // Act
          final result = await meetupRepository.getMeetupById(meetupId);

          // Assert
          expect(result, equals(testMeetupData));
          expect(result.id, '1');
          expect(result.title, 'Test Meetup');
        },
      );

      test('handles different meetup IDs correctly', () async {
        // Arrange
        const meetupId = '456';
        mockMeetupService.setGetMeetupByIdResult(testMeetupData2);

        // Act
        final result = await meetupRepository.getMeetupById(meetupId);

        // Assert
        expect(result, equals(testMeetupData2));
        expect(result.id, '2');
      });
    });

    group('getPreviousMeetups', () {
      test('delegates to MeetupService and returns list of meetups', () async {
        // Arrange
        const meetups = [testMeetupData, testMeetupData2];
        mockMeetupService.setGetPreviousMeetupsResult(meetups);

        // Act
        final result = await meetupRepository.getPreviousMeetups();

        // Assert
        expect(result, isA<List<Meetup>>());
        expect(result.length, 2);
        expect(result[0], equals(testMeetupData));
        expect(result[1], equals(testMeetupData2));
      });

      test('returns empty list when no previous meetups', () async {
        // Arrange
        mockMeetupService.setGetPreviousMeetupsResult([]);

        // Act
        final result = await meetupRepository.getPreviousMeetups();

        // Assert
        expect(result, isA<List<Meetup>>());
        expect(result.length, 0);
      });

      test('returns single meetup in list correctly', () async {
        // Arrange
        const meetups = [testMeetupData];
        mockMeetupService.setGetPreviousMeetupsResult(meetups);

        // Act
        final result = await meetupRepository.getPreviousMeetups();

        // Assert
        expect(result, isA<List<Meetup>>());
        expect(result.length, 1);
        expect(result[0], equals(testMeetupData));
      });
    });

    group('getAllMeetups', () {
      test('delegates to MeetupService and returns all meetups', () async {
        // Arrange
        const meetups = [testMeetupData, testMeetupData2];
        mockMeetupService.setGetAllMeetupsResult(meetups);

        // Act
        final result = await meetupRepository.getAllMeetups();

        // Assert
        expect(result, isA<List<Meetup>>());
        expect(result.length, 2);
        expect(result[0], equals(testMeetupData));
        expect(result[1], equals(testMeetupData2));
      });

      test('returns empty list when no meetups available', () async {
        // Arrange
        mockMeetupService.setGetAllMeetupsResult([]);

        // Act
        final result = await meetupRepository.getAllMeetups();

        // Assert
        expect(result, isA<List<Meetup>>());
        expect(result.length, 0);
      });

      test('returns large list of meetups correctly', () async {
        // Arrange
        final meetups = List.generate(
          10,
          (index) => testMeetupData.copyWith(id: '$index'),
        );
        mockMeetupService.setGetAllMeetupsResult(meetups);

        // Act
        final result = await meetupRepository.getAllMeetups();

        // Assert
        expect(result, isA<List<Meetup>>());
        expect(result.length, 10);
        for (int i = 0; i < 10; i++) {
          expect(result[i].id, '$i');
        }
      });
    });
  });
}
