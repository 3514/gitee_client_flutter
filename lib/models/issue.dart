import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "repo.dart";
part 'issue.g.dart';

@JsonSerializable()
class Issue {
    Issue();

    num id;
    String url;
    String repository_url;
    String labels_url;
    String comments_url;
    String html_url;
    String parent_url;
    String number;
    String state;
    String title;
    String body;
    User user;
    List labels;
    String assignee;
    List collaborators;
    Repo repository;
    String milestone;
    String created_at;
    String updated_at;
    String plan_started_at;
    String deadline;
    String finished_at;
    num scheduled_time;
    num comments;
    num priority;
    String issue_type;
    String program;
    bool security_hole;
    
    factory Issue.fromJson(Map<String,dynamic> json) => _$IssueFromJson(json);
    Map<String, dynamic> toJson() => _$IssueToJson(this);
}
