import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meetup_data.g.dart';

/// {@template meetup_data}
/// Meetup data model.
/// {@endtemplate}
@JsonSerializable()
class MeetupData extends Equatable {
  /// {@macro meetup_data}
  const MeetupData({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.isBookmarked = false,
  });

  /// Converts a JSON map to a meetup data object.
  factory MeetupData.fromJson(Map<String, dynamic> json) =>
      _$MeetupDataFromJson(json);

  /// The unique identifier for the meetup.
  final String id;

  /// The title of the meetup.
  final String title;

  /// The description of the meetup.
  final String description;

  /// The location where the meetup takes place.
  final String location;

  /// The date of the meetup in string format.
  final String date;

  /// Whether the meetup is bookmarked by the user.
  final bool isBookmarked;

  /// Converts the meetup data to a JSON map.
  Map<String, dynamic> toJson() => _$MeetupDataToJson(this);

  /// Creates a new instance of the meetup data with the given properties
  /// updated.
  MeetupData copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? date,
    bool? isBookmarked,
  }) {
    return MeetupData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, description, location, date, isBookmarked];
}
