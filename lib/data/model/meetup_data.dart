import 'package:equatable/equatable.dart';

class MeetupData extends Equatable {
  const MeetupData({
    required this.id,
    required this.title,
    required this.description,
    this.smallImageSrc = 'https://placehold.co/96x96.png',
    this.bannerImageSrc = 'https://placehold.co/380x205.png',
    required this.location,
    required this.date,
    this.isBookmarked = false,
  });

  final String id;
  final String title;
  final String description;
  final String smallImageSrc;
  final String bannerImageSrc;
  final String location;
  final String date;
  final bool isBookmarked;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    smallImageSrc,
    bannerImageSrc,
    location,
    date,
    isBookmarked,
  ];

  MeetupData copyWith({
    String? id,
    String? title,
    String? description,
    String? imageSrc,
    String? largeImageSrc,
    String? location,
    String? date,
    bool? isBookmarked,
  }) {
    return MeetupData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      smallImageSrc: imageSrc ?? this.smallImageSrc,
      bannerImageSrc: largeImageSrc ?? this.bannerImageSrc,
      location: location ?? this.location,
      date: date ?? this.date,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
