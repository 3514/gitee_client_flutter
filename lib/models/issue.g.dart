// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue()
    ..id = json['id'] as num
    ..url = json['url'] as String
    ..repository_url = json['repository_url'] as String
    ..labels_url = json['labels_url'] as String
    ..comments_url = json['comments_url'] as String
    ..html_url = json['html_url'] as String
    ..parent_url = json['parent_url'] as String
    ..number = json['number'] as String
    ..state = json['state'] as String
    ..title = json['title'] as String
    ..body = json['body'] as String
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..labels = json['labels'] as List
    ..assignee = json['assignee'] as String
    ..collaborators = json['collaborators'] as List
    ..repository = json['repository'] == null
        ? null
        : Repo.fromJson(json['repository'] as Map<String, dynamic>)
    ..milestone = json['milestone'] as String
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..plan_started_at = json['plan_started_at'] as String
    ..deadline = json['deadline'] as String
    ..finished_at = json['finished_at'] as String
    ..scheduled_time = json['scheduled_time'] as num
    ..comments = json['comments'] as num
    ..priority = json['priority'] as num
    ..issue_type = json['issue_type'] as String
    ..program = json['program'] as String
    ..security_hole = json['security_hole'] as bool;
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'repository_url': instance.repository_url,
      'labels_url': instance.labels_url,
      'comments_url': instance.comments_url,
      'html_url': instance.html_url,
      'parent_url': instance.parent_url,
      'number': instance.number,
      'state': instance.state,
      'title': instance.title,
      'body': instance.body,
      'user': instance.user,
      'labels': instance.labels,
      'assignee': instance.assignee,
      'collaborators': instance.collaborators,
      'repository': instance.repository,
      'milestone': instance.milestone,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'plan_started_at': instance.plan_started_at,
      'deadline': instance.deadline,
      'finished_at': instance.finished_at,
      'scheduled_time': instance.scheduled_time,
      'comments': instance.comments,
      'priority': instance.priority,
      'issue_type': instance.issue_type,
      'program': instance.program,
      'security_hole': instance.security_hole
    };
