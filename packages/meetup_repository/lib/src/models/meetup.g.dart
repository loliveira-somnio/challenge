// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meetup _$MeetupFromJson(Map<String, dynamic> json) => Meetup(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      smallImageSrc:
          json['smallImageSrc'] as String? ?? 'https://placehold.co/96x96.png',
      bannerImageSrc: json['bannerImageSrc'] as String? ??
          'https://placehold.co/380x205.png',
      location: json['location'] as String,
      date: json['date'] as String,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$MeetupToJson(Meetup instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'smallImageSrc': instance.smallImageSrc,
      'bannerImageSrc': instance.bannerImageSrc,
      'location': instance.location,
      'date': instance.date,
      'isBookmarked': instance.isBookmarked,
    };
