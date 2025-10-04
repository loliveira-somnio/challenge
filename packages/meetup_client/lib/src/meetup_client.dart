import 'dart:convert';
import 'package:meetup_client/src/helpers/json_response.dart';
import 'package:meetup_client/src/models/meetup_data.dart';

/// {@template meetup_service}
/// A service for accessing meetup data.
/// {@endtemplate}
class MeetupClient {
  /// Loads meetup data from JSON file
  Future<List<MeetupData>> loadMeetups() async {
    try {
      const jsonString = JsonResponse.meetupJson;

      final jsonList = jsonDecode(jsonString) as List<dynamic>;

      return jsonList
          .map((json) => MeetupData.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load meetups: $e');
    }
  }

  /// Gets the latest meetup (first in the list)
  Future<MeetupData> getLatestMeetup() async {
    final meetups = await loadMeetups();
    if (meetups.isEmpty) {
      throw Exception('No meetups found');
    }
    return meetups.first;
  }

  /// Gets a specific meetup by ID
  Future<MeetupData> getMeetupById(String meetupId) async {
    final meetups = await loadMeetups();
    try {
      return meetups.firstWhere((meetup) => meetup.id == meetupId);
    } catch (e) {
      throw Exception('Meetup with ID $meetupId not found');
    }
  }

  /// Gets all previous meetups (excluding the latest one)
  Future<List<MeetupData>> getPreviousMeetups() async {
    final meetups = await loadMeetups();
    if (meetups.length <= 1) {
      return [];
    }
    return meetups.skip(1).toList();
  }

  /// Gets all meetups
  Future<List<MeetupData>> getAllMeetups() async {
    return loadMeetups();
  }
}
