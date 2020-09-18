import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'notifyMessages.g.dart';

@JsonSerializable()
class NotifyMessages {
    NotifyMessages();

    num id;
    User sender;
    bool unread;
    String content;
    String updated_at;
    String url;
    String html_url;
    
    factory NotifyMessages.fromJson(Map<String,dynamic> json) => _$NotifyMessagesFromJson(json);
    Map<String, dynamic> toJson() => _$NotifyMessagesToJson(this);
}
