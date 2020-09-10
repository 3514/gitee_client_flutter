import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "namespace.dart";
part 'repoFeature.g.dart';

@JsonSerializable()
class RepoFeature {
    RepoFeature();

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
    Namespace namespace;
    String last_push_at;
    num parent_id;
    @JsonKey(name: 'fork?')
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
    
    factory RepoFeature.fromJson(Map<String,dynamic> json) => _$RepoFeatureFromJson(json);
    Map<String, dynamic> toJson() => _$RepoFeatureToJson(this);
}
