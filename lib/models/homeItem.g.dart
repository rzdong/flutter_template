// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeItem _$HomeItemFromJson(Map<String, dynamic> json) {
  return HomeItem()
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..tag = json['tag'] as String
    ..createdAt = json['createdAt'] as num
    ..picture = json['picture'] as String;
}

Map<String, dynamic> _$HomeItemToJson(HomeItem instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'tag': instance.tag,
      'createdAt': instance.createdAt,
      'picture': instance.picture
    };
