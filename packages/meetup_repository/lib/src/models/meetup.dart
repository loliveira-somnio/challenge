import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meetup.g.dart';

/// {@template meetup}
/// Meetup data model.
/// {@endtemplate}
@JsonSerializable()
class Meetup extends Equatable {
  /// {@macro meetup}
  const Meetup({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    this.smallImageSrc = 'https://placehold.co/96x96.png',
    this.bannerImageSrc = 'https://placehold.co/380x205.png',
    this.isBookmarked = false,
  });

  /// Converts a JSON map to a meetup data object.
  factory Meetup.fromJson(Map<String, dynamic> json) => _$MeetupFromJson(json);

  /// The unique identifier for the meetup.
  final String id;

  /// The title of the meetup.
  final String title;

  /// The description of the meetup.
  final String description;

  /// The URL for the small image associated with the meetup.
  final String smallImageSrc;

  /// The URL for the banner image associated with the meetup.
  final String bannerImageSrc;

  /// The location where the meetup takes place.
  final String location;

  /// The date of the meetup in string format.
  final String date;

  /// Whether the meetup is bookmarked by the user.
  final bool isBookmarked;

  /// Converts the meetup data to a JSON map.
  Map<String, dynamic> toJson() => _$MeetupToJson(this);

  /// Creates a new instance of the meetup data with the given properties
  /// updated.
  Meetup copyWith({
    String? id,
    String? title,
    String? description,
    String? smallImageSrc,
    String? bannerImageSrc,
    String? location,
    String? date,
    bool? isBookmarked,
  }) {
    return Meetup(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      smallImageSrc: smallImageSrc ?? this.smallImageSrc,
      bannerImageSrc: bannerImageSrc ?? this.bannerImageSrc,
      location: location ?? this.location,
      date: date ?? this.date,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        smallImageSrc,
        bannerImageSrc,
        location,
        date,
        isBookmarked
      ];
}
