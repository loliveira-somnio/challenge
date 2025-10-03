import '../model/meetup_data.dart';

abstract class MeetupRepository {
  Future<MeetupData> getLatestMeetup();
  Future<MeetupData> getMeetupById(String meetupId);
  Future<List<MeetupData>> getPreviousMeetups();
  Future<MeetupData> toggleBookmark(String meetupId, bool isBookmarked);
}

class MeetupRepositoryImpl implements MeetupRepository {
  @override
  Future<MeetupData> getLatestMeetup() async {
    await Future.delayed(const Duration(seconds: 1));
    return MeetupData(
      id: '1',
      title: 'Latest Meetup',
      description: 'Latest Meetup Description',
      location: 'São Paulo, SP',
      date: '20 de outubro de 2025',
    );
  }

  @override
  Future<MeetupData> getMeetupById(String meetupId) async {
    await Future.delayed(const Duration(seconds: 1));
    return MeetupData(
      id: meetupId,
      title: 'Meetup $meetupId',
      description: 'Meetup $meetupId Description',
      location: 'Localização $meetupId',
      date: 'Data $meetupId',
    );
  }

  @override
  Future<List<MeetupData>> getPreviousMeetups() async {
    await Future.delayed(const Duration(seconds: 1));
    final meetups = [
      MeetupData(
        id: '2',
        title: 'Previous Meetup 1',
        description: 'Previous Meetup 1 Description',
        location: 'Curitiba, PR',
        date: '15 de setembro de 2025',
      ),
      MeetupData(
        id: '3',
        title: 'Previous Meetup 2',
        description: 'Previous Meetup 2 Description',
        location: 'Porto Alegre, RS',
        date: '10 de agosto de 2025',
      ),
    ];
    return meetups;
  }

  @override
  Future<MeetupData> toggleBookmark(String meetupId, bool isBookmarked) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real implementation, this would update the bookmark status in a database or API.
    // Here, we just return a dummy MeetupData with the toggled bookmark status.
    return MeetupData(
      id: meetupId,
      title: 'Meetup $meetupId',
      description: 'Meetup $meetupId Description',
      location: 'Localização $meetupId',
      date: 'Data $meetupId',
      isBookmarked: isBookmarked,
    );
  }
}
