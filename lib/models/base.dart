import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "repo.dart";
part 'base.g.dart';

@JsonSerializable()
class Base {
    Base();

    String label;
    String ref;
    String sha;
    User user;
    Repo repo;
    
    factory Base.fromJson(Map<String,dynamic> json) => _$BaseFromJson(json);
    Map<String, dynamic> toJson() => _$BaseToJson(this);
}
