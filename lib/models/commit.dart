import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'commit.g.dart';

@JsonSerializable()
class Commit {
    Commit();

    String sha;
    User author;
    String message;
    String url;
    
    factory Commit.fromJson(Map<String,dynamic> json) => _$CommitFromJson(json);
    Map<String, dynamic> toJson() => _$CommitToJson(this);
}
