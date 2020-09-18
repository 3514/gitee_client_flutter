import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
    Subject();

    String title;
    String url;
    String latest_comment_url;
    String type;
    
    factory Subject.fromJson(Map<String,dynamic> json) => _$SubjectFromJson(json);
    Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
