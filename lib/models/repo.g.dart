// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo()
    ..id = json['id'] as num
    ..full_name = json['full_name'] as String
    ..human_name = json['human_name'] as String
    ..url = json['url'] as String
    ..namespace = json['namespace'] == null
        ? null
        : Namespace.fromJson(json['namespace'] as Map<String, dynamic>)
    ..path = json['path'] as String
    ..name = json['name'] as String
    ..owner = json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>)
    ..description = json['description'] as String
    ..private = json['private'] as bool
    ..public = json['public'] as bool
    ..internal = json['internal'] as bool
    ..fork = json['fork'] as bool
    ..html_url = json['html_url'] as String
    ..ssh_url = json['ssh_url'] as String;
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'human_name': instance.human_name,
      'url': instance.url,
      'namespace': instance.namespace,
      'path': instance.path,
      'name': instance.name,
      'owner': instance.owner,
      'description': instance.description,
      'private': instance.private,
      'public': instance.public,
      'internal': instance.internal,
      'fork': instance.fork,
      'html_url': instance.html_url,
      'ssh_url': instance.ssh_url
    };
