// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repoFeature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoFeature _$RepoFeatureFromJson(Map<String, dynamic> json) {
  return RepoFeature()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..default_branch = json['default_branch'] as String
    ..description = json['description'] as String
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..path = json['path'] as String
    ..path_with_namespace = json['path_with_namespace'] as String
    ..name_with_namespace = json['name_with_namespace'] as String
    ..issues_enabled = json['issues_enabled'] as bool
    ..pull_requests_enabled = json['pull_requests_enabled'] as bool
    ..wiki_enabled = json['wiki_enabled'] as bool
    ..created_at = json['created_at'] as String
    ..namespace = json['namespace'] == null
        ? null
        : Namespace.fromJson(json['namespace'] as Map<String, dynamic>)
    ..last_push_at = json['last_push_at'] as String
    ..parent_id = json['parent_id'] as num
    ..fork = json['fork?'] as bool
    ..forks_count = json['forks_count'] as num
    ..stars_count = json['stars_count'] as num
    ..watches_count = json['watches_count'] as num
    ..language = json['language'] as String
    ..paas = json['paas'] as String
    ..stared = json['stared'] as String
    ..watched = json['watched'] as String
    ..relation = json['relation'] as String
    ..recomm = json['recomm'] as num
    ..parent_path_with_namespace = json['parent_path_with_namespace'] as String;
}

Map<String, dynamic> _$RepoFeatureToJson(RepoFeature instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'default_branch': instance.default_branch,
      'description': instance.description,
      'owner': instance.owner,
      'public': instance.public,
      'path': instance.path,
      'path_with_namespace': instance.path_with_namespace,
      'name_with_namespace': instance.name_with_namespace,
      'issues_enabled': instance.issues_enabled,
      'pull_requests_enabled': instance.pull_requests_enabled,
      'wiki_enabled': instance.wiki_enabled,
      'created_at': instance.created_at,
      'namespace': instance.namespace,
      'last_push_at': instance.last_push_at,
      'parent_id': instance.parent_id,
      'fork?': instance.fork,
      'forks_count': instance.forks_count,
      'stars_count': instance.stars_count,
      'watches_count': instance.watches_count,
      'language': instance.language,
      'paas': instance.paas,
      'stared': instance.stared,
      'watched': instance.watched,
      'relation': instance.relation,
      'recomm': instance.recomm,
      'parent_path_with_namespace': instance.parent_path_with_namespace
    };
