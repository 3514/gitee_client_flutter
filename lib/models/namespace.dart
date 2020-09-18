import 'package:json_annotation/json_annotation.dart';

part 'namespace.g.dart';

@JsonSerializable()
class Namespace {
    Namespace();

    num id;
    String type;
    String name;
    String path;
    String html_url;
    
    factory Namespace.fromJson(Map<String,dynamic> json) => _$NamespaceFromJson(json);
    Map<String, dynamic> toJson() => _$NamespaceToJson(this);
}
