import 'package:challenge/event/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(MeetupEvent, () {
    group(SpecificMeetupRequested, () {
      test('is a MeetupEvent', () {
        expect(
          const SpecificMeetupRequested(id: 'test-id'),
          isA<MeetupEvent>(),
        );
      });

      test('has correct props', () {
        expect(
          const SpecificMeetupRequested(id: 'test-id').props,
          equals(['test-id']),
        );
      });

      test('supports equality', () {
        expect(
          const SpecificMeetupRequested(id: 'test-id'),
          equals(const SpecificMeetupRequested(id: 'test-id')),
        );
      });

      test('different ids are not equal', () {
        expect(
          const SpecificMeetupRequested(id: 'test-id-1'),
          isNot(equals(const SpecificMeetupRequested(id: 'test-id-2'))),
        );
      });
    });
  });
}
