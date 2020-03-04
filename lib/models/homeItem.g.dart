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
    ..created_at = json['created_at'] as num
    ..picture = json['picture'] as String;
}

Map<String, dynamic> _$HomeItemToJson(HomeItem instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'tag': instance.tag,
      'created_at': instance.created_at,
      'picture': instance.picture
    };
