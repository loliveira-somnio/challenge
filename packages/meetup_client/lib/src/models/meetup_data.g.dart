// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetup_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetupData _$MeetupDataFromJson(Map<String, dynamic> json) => MeetupData(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      date: json['date'] as String,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
    );

Map<String, dynamic> _$MeetupDataToJson(MeetupData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'date': instance.date,
      'isBookmarked': instance.isBookmarked,
    };
