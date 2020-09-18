import 'package:json_annotation/json_annotation.dart';
import "namespace.dart";
import "user.dart";
part 'repo.g.dart';

@JsonSerializable()
class Repo {
    Repo();

    num id;
    String full_name;
    String human_name;
    String url;
    Namespace namespace;
    String path;
    String name;
    User owner;
    String description;
    bool private;
    bool public;
    bool internal;
    bool fork;
    String html_url;
    String ssh_url;
    
    factory Repo.fromJson(Map<String,dynamic> json) => _$RepoFromJson(json);
    Map<String, dynamic> toJson() => _$RepoToJson(this);
}
