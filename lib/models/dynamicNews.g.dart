// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamicNews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicNews _$DynamicNewsFromJson(Map<String, dynamic> json) {
  return DynamicNews()
    ..id = json['id'] as num
    ..type = json['type'] as String
    ..actor = json['actor'] == null
        ? null
        : User.fromJson(json['actor'] as Map<String, dynamic>)
    ..repo = json['repo'] == null
        ? null
        : Repo.fromJson(json['repo'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..created_at = json['created_at'] as String
    ..payload = json['payload'] == null
        ? null
        : Payload.fromJson(json['payload'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DynamicNewsToJson(DynamicNews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'public': instance.public,
      'created_at': instance.created_at,
      'payload': instance.payload
    };
