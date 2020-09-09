// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as num
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..bio = json['bio'] as String
    ..weibo = json['weibo'] as String
    ..blog = json['blog'] as String
    ..theme_id = json['theme_id'] as num
    ..state = json['state'] as String
    ..created_at = json['created_at'] as String
    ..portrait_url = json['portrait_url'] as String
    ..new_portrait = json['new_portrait'] as String
    ..follow = json['follow'] as Map<String, dynamic>
    ..private_token = json['private_token'] as String
    ..is_admin = json['is_admin'] as bool
    ..can_create_group = json['can_create_group'] as bool
    ..can_create_project = json['can_create_project'] as bool
    ..can_create_team = json['can_create_team'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'bio': instance.bio,
      'weibo': instance.weibo,
      'blog': instance.blog,
      'theme_id': instance.theme_id,
      'state': instance.state,
      'created_at': instance.created_at,
      'portrait_url': instance.portrait_url,
      'new_portrait': instance.new_portrait,
      'follow': instance.follow,
      'private_token': instance.private_token,
      'is_admin': instance.is_admin,
      'can_create_group': instance.can_create_group,
      'can_create_project': instance.can_create_project,
      'can_create_team': instance.can_create_team
    };
