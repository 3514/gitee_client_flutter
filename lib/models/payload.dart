import 'package:gitee_client_flutter/models/links.dart';
import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'payload.g.dart';

@JsonSerializable()
class Payload {
    Payload();

    String action;
    num id;
    String url;
    String html_url;
    String diff_url;
    String patch_url;
    String issue_url;
    String commits_url;
    String review_comments_url;
    String review_comment_url;
    String comments_url;
    String statuses_url;
    num number;
    String state;
    String title;
    String body;
    num assignees_number;
    num testers_number;
    List assignees;
    List testers;
    String milestone;
    List labels;
    bool locked;
    String created_at;
    String updated_at;
    String closed_at;
    String merged_at;
    bool mergeable;
    bool can_merge_check;
    Map<String,dynamic> head;
    Map<String,dynamic> base;
    User user;
    @JsonKey(name: "_links")
    Links links;
    
    factory Payload.fromJson(Map<String,dynamic> json) => _$PayloadFromJson(json);
    Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
