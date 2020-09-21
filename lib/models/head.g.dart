// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'head.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Head _$HeadFromJson(Map<String, dynamic> json) {
  return Head()
    ..label = json['label'] as String
    ..ref = json['ref'] as String
    ..sha = json['sha'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..repo = json['repo'] == null
        ? null
        : Repo.fromJson(json['repo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$HeadToJson(Head instance) => <String, dynamic>{
      'label': instance.label,
      'ref': instance.ref,
      'sha': instance.sha,
      'user': instance.user,
      'repo': instance.repo
    };
