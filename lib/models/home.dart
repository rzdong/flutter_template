import 'package:json_annotation/json_annotation.dart';
import "homeCard.dart";
part 'home.g.dart';

@JsonSerializable()
class Home {
    Home();

    HomeCard news;
    HomeCard popular;
    HomeCard other;
    
    factory Home.fromJson(Map<String,dynamic> json) => _$HomeFromJson(json);
    Map<String, dynamic> toJson() => _$HomeToJson(this);
}
