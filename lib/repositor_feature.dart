/// id : 11396410
/// name : "carbon"
/// default_branch : "master"
/// description : "An golang package for DateTime  Go语言日期时间处理库，支持gorm结构体"
/// owner : {"id":544375,"username":"gouguoyin","email":"245629560@qq.com","state":"active","created_at":"2015-10-24T18:08:42+08:00","portrait_url":"https://portrait.gitee.com/uploads/avatars/user/181/544375_gouguoyin_1578927172.jpg","name":"gouguoyin","new_portrait":"https://portrait.gitee.com/uploads/avatars/user/181/544375_gouguoyin_1578927172.jpg"}
/// public : true
/// path : "carbon"
/// path_with_namespace : "go-package/carbon"
/// name_with_namespace : "go-package/carbon"
/// issues_enabled : true
/// pull_requests_enabled : true
/// wiki_enabled : true
/// created_at : "2020-09-07T17:15:31+08:00"
/// namespace : {"id":6294515,"name":"go-package","path":"go-package","owner_id":544375,"created_at":"2020-06-29T18:34:28+08:00","updated_at":"2020-09-07T18:16:41+08:00","description":"Golang扩展包，致力于打造最好的第三方Golang扩展包","address":"192.168.2.135","email":"","url":"","location":"","public":true,"enterprise_id":0,"level":0,"from":null,"outsourced":false,"avatar":"https://portrait.gitee.com/uploads/avatars/namespace/2098/6294515_go-package_1599473801.png?allow_nil=true"}
/// last_push_at : "2020-09-10T09:50:25+08:00"
/// parent_id : 0
/// fork? : false
/// forks_count : 2
/// stars_count : 17
/// watches_count : 4
/// language : "Go"
/// paas : null
/// stared : null
/// watched : null
/// relation : null
/// recomm : 1
/// parent_path_with_namespace : null

class RepositorFeature {
  int _id;
  String _name;
  String _defaultBranch;
  String _description;
  Owner _owner;
  bool _public;
  String _path;
  String _pathWithNamespace;
  String _nameWithNamespace;
  bool _issuesEnabled;
  bool _pullRequestsEnabled;
  bool _wikiEnabled;
  String _createdAt;
  Namespace _namespace;
  String _lastPushAt;
  int _parentId;
  bool _fork?;
  int _forksCount;
  int _starsCount;
  int _watchesCount;
  String _language;
  dynamic _paas;
  dynamic _stared;
  dynamic _watched;
  dynamic _relation;
  int _recomm;
  dynamic _parentPathWithNamespace;

  int get id => _id;
  String get name => _name;
  String get defaultBranch => _defaultBranch;
  String get description => _description;
  Owner get owner => _owner;
  bool get public => _public;
  String get path => _path;
  String get pathWithNamespace => _pathWithNamespace;
  String get nameWithNamespace => _nameWithNamespace;
  bool get issuesEnabled => _issuesEnabled;
  bool get pullRequestsEnabled => _pullRequestsEnabled;
  bool get wikiEnabled => _wikiEnabled;
  String get createdAt => _createdAt;
  Namespace get namespace => _namespace;
  String get lastPushAt => _lastPushAt;
  int get parentId => _parentId;
  bool get fork? => _fork?;
  int get forksCount => _forksCount;
  int get starsCount => _starsCount;
  int get watchesCount => _watchesCount;
  String get language => _language;
  dynamic get paas => _paas;
  dynamic get stared => _stared;
  dynamic get watched => _watched;
  dynamic get relation => _relation;
  int get recomm => _recomm;
  dynamic get parentPathWithNamespace => _parentPathWithNamespace;

  RepositorFeature({
      int id, 
      String name, 
      String defaultBranch, 
      String description, 
      Owner owner, 
      bool public, 
      String path, 
      String pathWithNamespace, 
      String nameWithNamespace, 
      bool issuesEnabled, 
      bool pullRequestsEnabled, 
      bool wikiEnabled, 
      String createdAt, 
      Namespace namespace, 
      String lastPushAt, 
      int parentId, 
      bool fork?, 
      int forksCount, 
      int starsCount, 
      int watchesCount, 
      String language, 
      dynamic paas, 
      dynamic stared, 
      dynamic watched, 
      dynamic relation, 
      int recomm, 
      dynamic parentPathWithNamespace}){
    _id = id;
    _name = name;
    _defaultBranch = defaultBranch;
    _description = description;
    _owner = owner;
    _public = public;
    _path = path;
    _pathWithNamespace = pathWithNamespace;
    _nameWithNamespace = nameWithNamespace;
    _issuesEnabled = issuesEnabled;
    _pullRequestsEnabled = pullRequestsEnabled;
    _wikiEnabled = wikiEnabled;
    _createdAt = createdAt;
    _namespace = namespace;
    _lastPushAt = lastPushAt;
    _parentId = parentId;
    _fork? = fork?;
    _forksCount = forksCount;
    _starsCount = starsCount;
    _watchesCount = watchesCount;
    _language = language;
    _paas = paas;
    _stared = stared;
    _watched = watched;
    _relation = relation;
    _recomm = recomm;
    _parentPathWithNamespace = parentPathWithNamespace;
}

  RepositorFeature.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _defaultBranch = json["defaultBranch"];
    _description = json["description"];
    _owner = json["owner"] != null ? Owner.fromJson(json["owner"]) : null;
    _public = json["public"];
    _path = json["path"];
    _pathWithNamespace = json["pathWithNamespace"];
    _nameWithNamespace = json["nameWithNamespace"];
    _issuesEnabled = json["issuesEnabled"];
    _pullRequestsEnabled = json["pullRequestsEnabled"];
    _wikiEnabled = json["wikiEnabled"];
    _createdAt = json["createdAt"];
    _namespace = json["namespace"] != null ? Namespace.fromJson(json["namespace"]) : null;
    _lastPushAt = json["lastPushAt"];
    _parentId = json["parentId"];
    _fork? = json["fork?"];
    _forksCount = json["forksCount"];
    _starsCount = json["starsCount"];
    _watchesCount = json["watchesCount"];
    _language = json["language"];
    _paas = json["paas"];
    _stared = json["stared"];
    _watched = json["watched"];
    _relation = json["relation"];
    _recomm = json["recomm"];
    _parentPathWithNamespace = json["parentPathWithNamespace"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["defaultBranch"] = _defaultBranch;
    map["description"] = _description;
    if (_owner != null) {
      map["owner"] = _owner.toJson();
    }
    map["public"] = _public;
    map["path"] = _path;
    map["pathWithNamespace"] = _pathWithNamespace;
    map["nameWithNamespace"] = _nameWithNamespace;
    map["issuesEnabled"] = _issuesEnabled;
    map["pullRequestsEnabled"] = _pullRequestsEnabled;
    map["wikiEnabled"] = _wikiEnabled;
    map["createdAt"] = _createdAt;
    if (_namespace != null) {
      map["namespace"] = _namespace.toJson();
    }
    map["lastPushAt"] = _lastPushAt;
    map["parentId"] = _parentId;
    map["fork?"] = _fork?;
    map["forksCount"] = _forksCount;
    map["starsCount"] = _starsCount;
    map["watchesCount"] = _watchesCount;
    map["language"] = _language;
    map["paas"] = _paas;
    map["stared"] = _stared;
    map["watched"] = _watched;
    map["relation"] = _relation;
    map["recomm"] = _recomm;
    map["parentPathWithNamespace"] = _parentPathWithNamespace;
    return map;
  }

}

/// id : 6294515
/// name : "go-package"
/// path : "go-package"
/// owner_id : 544375
/// created_at : "2020-06-29T18:34:28+08:00"
/// updated_at : "2020-09-07T18:16:41+08:00"
/// description : "Golang扩展包，致力于打造最好的第三方Golang扩展包"
/// address : "192.168.2.135"
/// email : ""
/// url : ""
/// location : ""
/// public : true
/// enterprise_id : 0
/// level : 0
/// from : null
/// outsourced : false
/// avatar : "https://portrait.gitee.com/uploads/avatars/namespace/2098/6294515_go-package_1599473801.png?allow_nil=true"

class Namespace {
  int _id;
  String _name;
  String _path;
  int _ownerId;
  String _createdAt;
  String _updatedAt;
  String _description;
  String _address;
  String _email;
  String _url;
  String _location;
  bool _public;
  int _enterpriseId;
  int _level;
  dynamic _from;
  bool _outsourced;
  String _avatar;

  int get id => _id;
  String get name => _name;
  String get path => _path;
  int get ownerId => _ownerId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get description => _description;
  String get address => _address;
  String get email => _email;
  String get url => _url;
  String get location => _location;
  bool get public => _public;
  int get enterpriseId => _enterpriseId;
  int get level => _level;
  dynamic get from => _from;
  bool get outsourced => _outsourced;
  String get avatar => _avatar;

  Namespace({
      int id, 
      String name, 
      String path, 
      int ownerId, 
      String createdAt, 
      String updatedAt, 
      String description, 
      String address, 
      String email, 
      String url, 
      String location, 
      bool public, 
      int enterpriseId, 
      int level, 
      dynamic from, 
      bool outsourced, 
      String avatar}){
    _id = id;
    _name = name;
    _path = path;
    _ownerId = ownerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _description = description;
    _address = address;
    _email = email;
    _url = url;
    _location = location;
    _public = public;
    _enterpriseId = enterpriseId;
    _level = level;
    _from = from;
    _outsourced = outsourced;
    _avatar = avatar;
}

  Namespace.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _path = json["path"];
    _ownerId = json["ownerId"];
    _createdAt = json["createdAt"];
    _updatedAt = json["updatedAt"];
    _description = json["description"];
    _address = json["address"];
    _email = json["email"];
    _url = json["url"];
    _location = json["location"];
    _public = json["public"];
    _enterpriseId = json["enterpriseId"];
    _level = json["level"];
    _from = json["from"];
    _outsourced = json["outsourced"];
    _avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["path"] = _path;
    map["ownerId"] = _ownerId;
    map["createdAt"] = _createdAt;
    map["updatedAt"] = _updatedAt;
    map["description"] = _description;
    map["address"] = _address;
    map["email"] = _email;
    map["url"] = _url;
    map["location"] = _location;
    map["public"] = _public;
    map["enterpriseId"] = _enterpriseId;
    map["level"] = _level;
    map["from"] = _from;
    map["outsourced"] = _outsourced;
    map["avatar"] = _avatar;
    return map;
  }

}

/// id : 544375
/// username : "gouguoyin"
/// email : "245629560@qq.com"
/// state : "active"
/// created_at : "2015-10-24T18:08:42+08:00"
/// portrait_url : "https://portrait.gitee.com/uploads/avatars/user/181/544375_gouguoyin_1578927172.jpg"
/// name : "gouguoyin"
/// new_portrait : "https://portrait.gitee.com/uploads/avatars/user/181/544375_gouguoyin_1578927172.jpg"

class Owner {
  int _id;
  String _username;
  String _email;
  String _state;
  String _createdAt;
  String _portraitUrl;
  String _name;
  String _newPortrait;

  int get id => _id;
  String get username => _username;
  String get email => _email;
  String get state => _state;
  String get createdAt => _createdAt;
  String get portraitUrl => _portraitUrl;
  String get name => _name;
  String get newPortrait => _newPortrait;

  Owner({
      int id, 
      String username, 
      String email, 
      String state, 
      String createdAt, 
      String portraitUrl, 
      String name, 
      String newPortrait}){
    _id = id;
    _username = username;
    _email = email;
    _state = state;
    _createdAt = createdAt;
    _portraitUrl = portraitUrl;
    _name = name;
    _newPortrait = newPortrait;
}

  Owner.fromJson(dynamic json) {
    _id = json["id"];
    _username = json["username"];
    _email = json["email"];
    _state = json["state"];
    _createdAt = json["createdAt"];
    _portraitUrl = json["portraitUrl"];
    _name = json["name"];
    _newPortrait = json["newPortrait"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["username"] = _username;
    map["email"] = _email;
    map["state"] = _state;
    map["createdAt"] = _createdAt;
    map["portraitUrl"] = _portraitUrl;
    map["name"] = _name;
    map["newPortrait"] = _newPortrait;
    return map;
  }

}