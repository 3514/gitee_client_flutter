import 'package:json_annotation/json_annotation.dart';

part 'oauth.g.dart';

@JsonSerializable()
class Oauth {
    Oauth();

    String access_token;
    String token_type;
    num expires_in;
    String refresh_token;
    String scope;
    num created_at;
    
    factory Oauth.fromJson(Map<String,dynamic> json) => _$OauthFromJson(json);
    Map<String, dynamic> toJson() => _$OauthToJson(this);
}
