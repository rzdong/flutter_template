import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Home {
    Home();

    Map<String,dynamic> news;
    Map<String,dynamic> popular;
    Map<String,dynamic> other;
    
    factory Home.fromJson(Map<String,dynamic> json) => _$HomeFromJson(json);
    Map<String, dynamic> toJson() => _$HomeToJson(this);
}
