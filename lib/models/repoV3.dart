import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "namespaceV3.dart";
part 'repoV3.g.dart';

@JsonSerializable()
class RepoV3 {
    RepoV3();

    num id;
    String name;
    String default_branch;
    String description;
    User owner;
    bool public;
    String path;
    String path_with_namespace;
    String name_with_namespace;
    bool issues_enabled;
    bool pull_requests_enabled;
    bool wiki_enabled;
    String created_at;
    NamespaceV3 namespace;
    String last_push_at;
    num parent_id;
    @JsonKey(name: "fork?")
    bool fork;
    num forks_count;
    num stars_count;
    num watches_count;
    String language;
    String paas;
    String stared;
    String watched;
    String relation;
    num recomm;
    String parent_path_with_namespace;

    factory RepoV3.fromJson(Map<String,dynamic> json) => _$RepoV3FromJson(json);
    Map<String, dynamic> toJson() => _$RepoV3ToJson(this);
}
