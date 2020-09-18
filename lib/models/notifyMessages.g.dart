// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifyMessages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyMessages _$NotifyMessagesFromJson(Map<String, dynamic> json) {
  return NotifyMessages()
    ..id = json['id'] as num
    ..sender = json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>)
    ..unread = json['unread'] as bool
    ..content = json['content'] as String
    ..updated_at = json['updated_at'] as String
    ..url = json['url'] as String
    ..html_url = json['html_url'] as String;
}

Map<String, dynamic> _$NotifyMessagesToJson(NotifyMessages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'unread': instance.unread,
      'content': instance.content,
      'updated_at': instance.updated_at,
      'url': instance.url,
      'html_url': instance.html_url
    };
