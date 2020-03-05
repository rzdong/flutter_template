// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Home _$HomeFromJson(Map<String, dynamic> json) {
  return Home()
    ..news = json['news'] == null
        ? null
        : HomeCard.fromJson(json['news'] as Map<String, dynamic>)
    ..popular = json['popular'] == null
        ? null
        : HomeCard.fromJson(json['popular'] as Map<String, dynamic>)
    ..other = json['other'] == null
        ? null
        : HomeCard.fromJson(json['other'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'news': instance.news,
      'popular': instance.popular,
      'other': instance.other
    };
