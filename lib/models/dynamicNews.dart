import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "repo.dart";
import "payload.dart";
part 'dynamicNews.g.dart';

@JsonSerializable()
class DynamicNews {
    DynamicNews();

    num id;
    String type;
    User actor;
    Repo repo;
    bool public;
    String created_at;
    Payload payload;
    
    factory DynamicNews.fromJson(Map<String,dynamic> json) => _$DynamicNewsFromJson(json);
    Map<String, dynamic> toJson() => _$DynamicNewsToJson(this);
}
