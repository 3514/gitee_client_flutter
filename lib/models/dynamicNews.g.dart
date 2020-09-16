// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamicNews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicNews _$DynamicNewsFromJson(Map<String, dynamic> json) {
  return DynamicNews()
    ..id = json['id'] as num
    ..content = json['content'] as String
    ..type = json['type'] as String
    ..unread = json['unread'] as bool
    ..mute = json['mute'] as bool
    ..updated_at = json['updated_at'] as String
    ..url = json['url'] as String
    ..html_url = json['html_url'] as String
    ..actor = json['actor'] as Map<String, dynamic>
    ..repository = json['repository'] as Map<String, dynamic>
    ..subject = json['subject'] as Map<String, dynamic>
    ..namespaces = json['namespaces'] as List;
}

Map<String, dynamic> _$DynamicNewsToJson(DynamicNews instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'unread': instance.unread,
      'mute': instance.mute,
      'updated_at': instance.updated_at,
      'url': instance.url,
      'html_url': instance.html_url,
      'actor': instance.actor,
      'repository': instance.repository,
      'subject': instance.subject,
      'namespaces': instance.namespaces
    };
