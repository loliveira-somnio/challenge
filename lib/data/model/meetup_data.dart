import 'package:equatable/equatable.dart';

class MeetupData extends Equatable {
  final String id;
  final String title;
  final String description;
  final String smallImageSrc;
  final String bannerImageSrc;
  final String location;
  final String date;
  final bool isBookmarked;

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

  factory MeetupData.fromJson(Map<String, dynamic> json) {
    return MeetupData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      smallImageSrc: json['smallImageSrc'],
      bannerImageSrc: json['bannerImageSrc'],
      location: json['location'],
      date: json['date'],
      isBookmarked: json['isBookmarked'],
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
    isBookmarked,
  ];

  MeetupData copyWith({
    String? id,
    String? title,
    String? description,
    String? smallImageSrc,
    String? bannerImageSrc,
    String? location,
    String? date,
    bool? isBookmarked,
  }) {
    return MeetupData(
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
}
