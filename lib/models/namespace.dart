import 'package:json_annotation/json_annotation.dart';

part 'namespace.g.dart';

@JsonSerializable()
class Namespace {
    Namespace();

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
    
    factory Namespace.fromJson(Map<String,dynamic> json) => _$NamespaceFromJson(json);
    Map<String, dynamic> toJson() => _$NamespaceToJson(this);
}
