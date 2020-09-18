// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links()
    ..self = json['self'] as Map<String, dynamic>
    ..html = json['html'] as Map<String, dynamic>
    ..issue = json['issue'] as Map<String, dynamic>
    ..comments = json['comments'] as Map<String, dynamic>
    ..review_comments = json['review_comments'] as Map<String, dynamic>
    ..review_comment = json['review_comment'] as Map<String, dynamic>
    ..commits = json['commits'] as Map<String, dynamic>
    ..statuses = json['statuses'] as Map<String, dynamic>;
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'self': instance.self,
      'html': instance.html,
      'issue': instance.issue,
      'comments': instance.comments,
      'review_comments': instance.review_comments,
      'review_comment': instance.review_comment,
      'commits': instance.commits,
      'statuses': instance.statuses
    };
