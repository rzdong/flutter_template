import 'package:json_annotation/json_annotation.dart';

part 'homeItem.g.dart';

@JsonSerializable()
class HomeItem {
    HomeItem();

    String title;
    String content;
    String tag;
    num created_at;
    String picture;
    
    factory HomeItem.fromJson(Map<String,dynamic> json) => _$HomeItemFromJson(json);
    Map<String, dynamic> toJson() => _$HomeItemToJson(this);
}
