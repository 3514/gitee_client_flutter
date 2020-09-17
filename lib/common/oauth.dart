import '../index.dart';

class OAuth {
  static final OAuth _shared = new OAuth._internal();

  OAuth._internal();

  factory OAuth() {
    return _shared;
  }

  Oauth _oauth;
  DateTime _createdAt;
  User _user;

  String token() => _oauth?.access_token ?? Global.profile.oauth.access_token;

  void updateUser(User newUser) {
    _user = newUser;
  }

  ///程序启动时调用，检查本地用户信息
  Future prepare() async {
    _oauth = Global.profile.oauth;
    if (_oauth == null) return this;

    _formatCreatedAt((_oauth?.created_at as int) ?? 0);
    if (isExpired) {
      await refreshAccessToken();
      return this;
    }
    if (_oauth?.access_token == null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _oauth.access_token = prefs.getString("access_token");
      _oauth.refresh_token = prefs.getString("refresh_token");
      _oauth.expires_in = prefs.getInt("expires_in") ?? 0;
      _formatCreatedAt(prefs.getInt("created_at") ?? 0);
    }
    print("prepare: ${!isExpired}");
    return this;
  }

  Future<void> storeToken(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _oauth = Oauth();
    _oauth.access_token = data["access_token"];
    _oauth.refresh_token = data["refresh_token"];
    _oauth.expires_in = data["expires_in"];
    int time = data["created_at"] ?? 0;
    _oauth.created_at = time;
    _formatCreatedAt(time);
    Global.profile.oauth = _oauth;
    Global.profile.oauth.access_token = _oauth.access_token; //更新profile中的token信息

    prefs.setInt("expires_in", _oauth.expires_in);
    prefs.setString("access_token", _oauth.access_token);
    prefs.setString("refresh_token", _oauth.refresh_token);
    prefs.setInt("created_at", time);
    print("storeToken completed -->-->--> ${_oauth?.toString()} \n");
  }

  ///是否已经登录
  /// *仅判断本地是否已经存有user*
  bool get isAuthorized {
    return _oauth.access_token != null;
  }

  ///判断是access_token是否过期
  bool get isExpired {
    if (_createdAt != null && isAuthorized) {
      return _createdAt.add(new Duration(seconds: _oauth.expires_in)).isBefore(new DateTime.now());
    }
    return true;
  }

  Future<bool> refreshAccessToken() async {
    try {
      var data = await GiteeApi().refreshToken(_oauth.refresh_token);
      print(data);
      await storeToken(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  DateTime _formatCreatedAt(int time) => _createdAt = DateTime.fromMillisecondsSinceEpoch(time * 1000);

  @override
  String toString() {
    return "accessToken: ${_oauth.access_token} | refreshToken: ${_oauth.refresh_token} "
        "| 有效期: ${_oauth.expires_in} | 创建日期：$_createdAt | 是否过期：$isExpired";
  }

  void logout() {
    Global.profile.oauth = null;
    _createdAt = null;
  }
}
