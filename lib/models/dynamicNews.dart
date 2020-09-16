import 'package:json_annotation/json_annotation.dart';

part 'dynamicNews.g.dart';

@JsonSerializable()
class DynamicNews {
    DynamicNews();

    num id;
    String content;
    String type;
    bool unread;
    bool mute;
    String updated_at;
    String url;
    String html_url;
    Map<String,dynamic> actor;
    Map<String,dynamic> repository;
    Map<String,dynamic> subject;
    List namespaces;
    
    factory DynamicNews.fromJson(Map<String,dynamic> json) => _$DynamicNewsFromJson(json);
    Map<String, dynamic> toJson() => _$DynamicNewsToJson(this);
}
