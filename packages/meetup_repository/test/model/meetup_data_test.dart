import 'package:meetup_repository/meetup_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MeetupData', () {
    const testMeetupData = Meetup(
      id: '1',
      title: 'Test Meetup',
      description: 'Test description',
      smallImageSrc: 'https://example.com/small.png',
      bannerImageSrc: 'https://example.com/banner.png',
      location: 'Test Location',
      date: '2025-01-01',
      isBookmarked: true,
    );

    group('constructor', () {
      test('creates instance with all required parameters', () {
        const meetup = Meetup(
          id: '1',
          title: 'Test Title',
          description: 'Test Description',
          location: 'Test Location',
          date: '2025-01-01',
        );

        expect(meetup.id, '1');
        expect(meetup.title, 'Test Title');
        expect(meetup.description, 'Test Description');
        expect(meetup.smallImageSrc, 'https://placehold.co/96x96.png');
        expect(meetup.bannerImageSrc, 'https://placehold.co/380x205.png');
        expect(meetup.location, 'Test Location');
        expect(meetup.date, '2025-01-01');
        expect(meetup.isBookmarked, false);
      });

      test('creates instance with default values', () {
        const meetup = Meetup(
          id: '1',
          title: 'Test Title',
          description: 'Test Description',
          location: 'Test Location',
          date: '2025-01-01',
        );

        expect(meetup.smallImageSrc, 'https://placehold.co/96x96.png');
        expect(meetup.bannerImageSrc, 'https://placehold.co/380x205.png');
        expect(meetup.isBookmarked, false);
      });

      test('creates instance with custom optional parameters', () {
        const meetup = Meetup(
          id: '1',
          title: 'Test Title',
          description: 'Test Description',
          smallImageSrc: 'https://custom.com/small.png',
          bannerImageSrc: 'https://custom.com/banner.png',
          location: 'Test Location',
          date: '2025-01-01',
          isBookmarked: true,
        );

        expect(meetup.smallImageSrc, 'https://custom.com/small.png');
        expect(meetup.bannerImageSrc, 'https://custom.com/banner.png');
        expect(meetup.isBookmarked, true);
      });
    });

    group('fromJson', () {
      test('creates instance from valid JSON', () {
        const json = {
          'id': '1',
          'title': 'Test Meetup',
          'description': 'Test description',
          'smallImageSrc': 'https://example.com/small.png',
          'bannerImageSrc': 'https://example.com/banner.png',
          'location': 'Test Location',
          'date': '2025-01-01',
          'isBookmarked': true,
        };

        final meetup = Meetup.fromJson(json);

        expect(meetup.id, '1');
        expect(meetup.title, 'Test Meetup');
        expect(meetup.description, 'Test description');
        expect(meetup.smallImageSrc, 'https://example.com/small.png');
        expect(meetup.bannerImageSrc, 'https://example.com/banner.png');
        expect(meetup.location, 'Test Location');
        expect(meetup.date, '2025-01-01');
        expect(meetup.isBookmarked, true);
      });
    });

    group('copyWith', () {
      test(
        'returns new instance with same values when no parameters provided',
        () {
          final copied = testMeetupData.copyWith();

          expect(copied, equals(testMeetupData));
          expect(identical(copied, testMeetupData), isFalse);
        },
      );

      test('returns new instance with all fields updated', () {
        final copied = testMeetupData.copyWith(
          id: '2',
          title: 'New Title',
          description: 'New Description',
          smallImageSrc: 'https://new.com/small.png',
          bannerImageSrc: 'https://new.com/banner.png',
          location: 'New Location',
          date: '2025-02-01',
          isBookmarked: false,
        );

        expect(copied.id, '2');
        expect(copied.title, 'New Title');
        expect(copied.description, 'New Description');
        expect(copied.smallImageSrc, 'https://new.com/small.png');
        expect(copied.bannerImageSrc, 'https://new.com/banner.png');
        expect(copied.location, 'New Location');
        expect(copied.date, '2025-02-01');
        expect(copied.isBookmarked, false);
      });
    });

    group('equality', () {
      test('two instances with same values are equal', () {
        const meetup1 = Meetup(
          id: '1',
          title: 'Test Meetup',
          description: 'Test description',
          location: 'Test Location',
          date: '2025-01-01',
          isBookmarked: true,
        );

        const meetup2 = Meetup(
          id: '1',
          title: 'Test Meetup',
          description: 'Test description',
          location: 'Test Location',
          date: '2025-01-01',
          isBookmarked: true,
        );

        expect(meetup1, equals(meetup2));
        expect(meetup1.hashCode, equals(meetup2.hashCode));
      });

      test('two instances with different values are not equal', () {
        const meetup1 = Meetup(
          id: '1',
          title: 'Test Meetup',
          description: 'Test description',
          location: 'Test Location',
          date: '2025-01-01',
          isBookmarked: true,
        );

        const meetup2 = Meetup(
          id: '2',
          title: 'Test Meetup',
          description: 'Test description',
          location: 'Test Location',
          date: '2025-01-01',
          isBookmarked: true,
        );

        expect(meetup1, isNot(equals(meetup2)));
      });
    });
  });
}
