import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
    Auth();

    String access_token;
    String token_type;
    num expires_in;
    String refresh_token;
    String scope;
    num created_at;
    
    factory Auth.fromJson(Map<String,dynamic> json) => _$AuthFromJson(json);
    Map<String, dynamic> toJson() => _$AuthToJson(this);
}
