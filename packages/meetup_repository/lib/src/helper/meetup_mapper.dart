import 'package:meetup_client/meetup_client.dart';
import 'package:meetup_repository/src/models/meetup.dart';

/// {@template meetup_mapper}
/// A mapper for converting [MeetupData] to [Meetup].
/// {@endtemplate}
class MeetupMapper {
  /// {@macro meetup_mapper}
  static Meetup fromMeetupData(MeetupData meetupData) {
    return Meetup(
      id: meetupData.id,
      title: meetupData.title,
      description: meetupData.description,
      location: meetupData.location,
      date: meetupData.date,
      isBookmarked: meetupData.isBookmarked,
    );
  }

  static List<Meetup> fromMeetupDataList(List<MeetupData> meetupDataList) {
    return meetupDataList.map(fromMeetupData).toList();
  }
}
