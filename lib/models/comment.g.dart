// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..url = json['url'] as String
    ..html_url = json['html_url'] as String
    ..issue_url = json['issue_url'] as String
    ..id = json['id'] as num
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..body = json['body'] as String;
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'url': instance.url,
      'html_url': instance.html_url,
      'issue_url': instance.issue_url,
      'id': instance.id,
      'user': instance.user,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'body': instance.body
    };
