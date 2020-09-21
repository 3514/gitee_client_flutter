import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "repo.dart";
part 'head.g.dart';

@JsonSerializable()
class Head {
    Head();

    String label;
    String ref;
    String sha;
    User user;
    Repo repo;
    
    factory Head.fromJson(Map<String,dynamic> json) => _$HeadFromJson(json);
    Map<String, dynamic> toJson() => _$HeadToJson(this);
}
