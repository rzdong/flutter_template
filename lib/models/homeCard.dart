import 'package:json_annotation/json_annotation.dart';
import "homeItem.dart";
part 'homeCard.g.dart';

@JsonSerializable()
class HomeCard {
    HomeCard();

    String title;
    List<HomeItem> list;
    
    factory HomeCard.fromJson(Map<String,dynamic> json) => _$HomeCardFromJson(json);
    Map<String, dynamic> toJson() => _$HomeCardToJson(this);
}
