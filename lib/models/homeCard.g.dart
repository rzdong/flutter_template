// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeCard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCard _$HomeCardFromJson(Map<String, dynamic> json) {
  return HomeCard()
    ..title = json['title'] as String
    ..list = (json['list'] as List)
        ?.map((e) =>
            e == null ? null : HomeItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeCardToJson(HomeCard instance) =>
    <String, dynamic>{'title': instance.title, 'list': instance.list};
