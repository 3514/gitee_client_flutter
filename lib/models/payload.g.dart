// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map<String, dynamic> json) {
  return Payload()
    ..action = json['action'] as String
    ..id = json['id'] as num
    ..url = json['url'] as String
    ..html_url = json['html_url'] as String
    ..diff_url = json['diff_url'] as String
    ..patch_url = json['patch_url'] as String
    ..issue_url = json['issue_url'] as String
    ..commits_url = json['commits_url'] as String
    ..review_comments_url = json['review_comments_url'] as String
    ..review_comment_url = json['review_comment_url'] as String
    ..comments_url = json['comments_url'] as String
    ..statuses_url = json['statuses_url'] as String
    ..number = (json['number'] as Object)?.toString()
    ..state = json['state'] as String
    ..title = json['title'] as String
    ..body = json['body'] as String
    ..assignees_number = json['assignees_number'] as num
    ..testers_number = json['testers_number'] as num
    ..assignees = json['assignees'] as List
    ..testers = json['testers'] as List
    ..milestone = json['milestone'] as String
    ..labels = json['labels'] as List
    ..locked = json['locked'] as bool
    ..created_at = json['created_at'] as String
    ..updated_at = json['updated_at'] as String
    ..closed_at = json['closed_at'] as String
    ..merged_at = json['merged_at'] as String
    ..mergeable = json['mergeable'] as bool
    ..can_merge_check = json['can_merge_check'] as bool
    ..head = json['head'] as Map<String, dynamic>
    ..base = json['base'] as Map<String, dynamic>
    ..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>)
    ..issue = json['issue'] == null
        ? null
        : Issue.fromJson(json['issue'] as Map<String, dynamic>)
    ..comment = json['comment'] == null
        ? null
        : Comment.fromJson(json['comment'] as Map<String, dynamic>)
    ..repository = json['repository'] == null
        ? null
        : Repo.fromJson(json['repository'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'action': instance.action,
      'id': instance.id,
      'url': instance.url,
      'html_url': instance.html_url,
      'diff_url': instance.diff_url,
      'patch_url': instance.patch_url,
      'issue_url': instance.issue_url,
      'commits_url': instance.commits_url,
      'review_comments_url': instance.review_comments_url,
      'review_comment_url': instance.review_comment_url,
      'comments_url': instance.comments_url,
      'statuses_url': instance.statuses_url,
      'number': instance.number,
      'state': instance.state,
      'title': instance.title,
      'body': instance.body,
      'assignees_number': instance.assignees_number,
      'testers_number': instance.testers_number,
      'assignees': instance.assignees,
      'testers': instance.testers,
      'milestone': instance.milestone,
      'labels': instance.labels,
      'locked': instance.locked,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'closed_at': instance.closed_at,
      'merged_at': instance.merged_at,
      'mergeable': instance.mergeable,
      'can_merge_check': instance.can_merge_check,
      'head': instance.head,
      'base': instance.base,
      'user': instance.user,
      'issue': instance.issue,
      'comment': instance.comment,
      'repository': instance.repository
    };
