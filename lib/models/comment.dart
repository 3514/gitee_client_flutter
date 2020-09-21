import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'comment.g.dart';

@JsonSerializable()
class Comment {
    Comment();

    String url;
    String html_url;
    String issue_url;
    num id;
    User user;
    String created_at;
    String updated_at;
    String body;
    
    factory Comment.fromJson(Map<String,dynamic> json) => _$CommentFromJson(json);
    Map<String, dynamic> toJson() => _$CommentToJson(this);
}
