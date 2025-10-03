import '../model/meetup_data.dart';
import '../services/meetup_service.dart';

abstract class MeetupRepository {
  Future<MeetupData> getLatestMeetup();
  Future<MeetupData> getMeetupById(String meetupId);
  Future<List<MeetupData>> getPreviousMeetups();
  Future<List<MeetupData>> getAllMeetups();
}

class MeetupRepositoryImpl implements MeetupRepository {
  const MeetupRepositoryImpl(this._meetupService);

  final MeetupService _meetupService;

  @override
  Future<MeetupData> getLatestMeetup() async {
    return await _meetupService.getLatestMeetup();
  }

  @override
  Future<MeetupData> getMeetupById(String meetupId) async {
    return await _meetupService.getMeetupById(meetupId);
  }

  @override
  Future<List<MeetupData>> getPreviousMeetups() async {
    return await _meetupService.getPreviousMeetups();
  }

  @override
  Future<List<MeetupData>> getAllMeetups() async {
    return await _meetupService.getAllMeetups();
  }
}
