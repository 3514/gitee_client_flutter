import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "repo.dart";
import "subject.dart";
import "namespace.dart";
part 'notifications.g.dart';

@JsonSerializable()
class Notifications {
    Notifications();

    num id;
    String content;
    String type;
    bool unread;
    bool mute;
    String updated_at;
    String url;
    String html_url;
    User actor;
    Repo repository;
    Subject subject;
    List<Namespace> namespaces;
    
    factory Notifications.fromJson(Map<String,dynamic> json) => _$NotificationsFromJson(json);
    Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}
