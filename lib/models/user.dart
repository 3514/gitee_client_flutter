import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num id;
    String username;
    String name;
    String bio;
    String weibo;
    String blog;
    num theme_id;
    String state;
    String created_at;
    String portrait_url;
    String new_portrait;
    Map<String,dynamic> follow;
    String private_token;
    bool is_admin;
    bool can_create_group;
    bool can_create_project;
    bool can_create_team;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
