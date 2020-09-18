// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namespace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Namespace _$NamespaceFromJson(Map<String, dynamic> json) {
  return Namespace()
    ..id = json['id'] as num
    ..type = json['type'] as String
    ..name = json['name'] as String
    ..path = json['path'] as String
    ..html_url = json['html_url'] as String;
}

Map<String, dynamic> _$NamespaceToJson(Namespace instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'path': instance.path,
      'html_url': instance.html_url
    };
