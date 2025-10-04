import 'package:meetup_client/meetup_client.dart';
import 'package:meetup_repository/src/helper/meetup_mapper.dart';
import 'package:meetup_repository/src/models/meetup.dart';

/// {@template meetup_repository}
/// A repository for managing meetup data.
/// {@endtemplate}
class MeetupRepository {
  /// {@macro meetup_repository}
  const MeetupRepository(this._meetupService);

  /// The meetup service to use for data access.
  final MeetupClient _meetupService;

  /// Gets the latest meetup from the service.
  Future<Meetup> getLatestMeetup() async {
    return MeetupMapper.fromMeetupData(await _meetupService.getLatestMeetup());
  }

  /// Gets a meetup by its ID from the service.
  Future<Meetup> getMeetupById(String meetupId) async {
    return MeetupMapper.fromMeetupData(
      await _meetupService.getMeetupById(meetupId),
    );
  }

  /// Gets all previous meetups from the service.
  Future<List<Meetup>> getPreviousMeetups() async {
    return MeetupMapper.fromMeetupDataList(
      await _meetupService.getPreviousMeetups(),
    );
  }

  /// Gets all meetups from the service.
  Future<List<Meetup>> getAllMeetups() async {
    return MeetupMapper.fromMeetupDataList(
      await _meetupService.getAllMeetups(),
    );
  }
}
