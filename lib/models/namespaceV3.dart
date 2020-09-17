import 'package:json_annotation/json_annotation.dart';

part 'namespaceV3.g.dart';

@JsonSerializable()
class NamespaceV3 {
    NamespaceV3();

    num id;
    String name;
    String path;
    num owner_id;
    String created_at;
    String updated_at;
    String description;
    String address;
    String email;
    String url;
    String location;
    bool public;
    num enterprise_id;
    num level;
    String from;
    bool outsourced;
    String avatar;
    
    factory NamespaceV3.fromJson(Map<String,dynamic> json) => _$NamespaceV3FromJson(json);
    Map<String, dynamic> toJson() => _$NamespaceV3ToJson(this);
}
