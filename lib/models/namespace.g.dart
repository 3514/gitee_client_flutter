// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namespace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Namespace _$NamespaceFromJson(Map<String, dynamic> json) {
  return Namespace()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..path = json['path'] as String
    ..owner_id = json['owner_id'] as num
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..description = json['description'] as String
    ..address = json['address'] as String
    ..email = json['email'] as String
    ..url = json['url'] as String
    ..location = json['location'] as String
    ..public = json['public'] as bool
    ..enterprise_id = json['enterprise_id'] as num
    ..level = json['level'] as num
    ..from = json['from'] as String
    ..outsourced = json['outsourced'] as bool
    ..avatar = json['avatar'] as String;
}

Map<String, dynamic> _$NamespaceToJson(Namespace instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'owner_id': instance.owner_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'description': instance.description,
      'address': instance.address,
      'email': instance.email,
      'url': instance.url,
      'location': instance.location,
      'public': instance.public,
      'enterprise_id': instance.enterprise_id,
      'level': instance.level,
      'from': instance.from,
      'outsourced': instance.outsourced,
      'avatar': instance.avatar
    };
