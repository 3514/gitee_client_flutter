import 'package:json_annotation/json_annotation.dart';

part 'links.g.dart';

@JsonSerializable()
class Links {
    Links();

    Map<String,dynamic> self;
    Map<String,dynamic> html;
    Map<String,dynamic> issue;
    Map<String,dynamic> comments;
    Map<String,dynamic> review_comments;
    Map<String,dynamic> review_comment;
    Map<String,dynamic> commits;
    Map<String,dynamic> statuses;
    
    factory Links.fromJson(Map<String,dynamic> json) => _$LinksFromJson(json);
    Map<String, dynamic> toJson() => _$LinksToJson(this);
}
