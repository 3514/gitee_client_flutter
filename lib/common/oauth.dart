import '../index.dart';

class OAuth {
  static final OAuth _shared = new OAuth._internal();

  OAuth._internal();

  factory OAuth() {
    return _shared;
  }

  Oauth _oauth;
  DateTime _createdAt;

  String token() => _oauth?.access_token ?? Global.profile.oauth.access_token;

  ///程序启动时调用，检查本地用户信息
  Future prepare() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access_token") == null) return this;
    _oauth = new Oauth();
    _oauth.expires_in = prefs.getInt("expires_in") ?? 0;
    _oauth.access_token = prefs.getString("access_token");
    _oauth.refresh_token = prefs.getString("refresh_token");
    _oauth.scope = prefs.getString("scope");
    _oauth.created_at = prefs.getInt("created_at") ?? 0;
    Global.profile.oauth = _oauth;

    _resetCreatedAt((_oauth?.created_at as int) ?? 0);
    if (isExpired) await refreshAccessToken();
    print("prepare isExpired : $isExpired");
    return this;
  }

  Future<void> storeToken(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _oauth = Oauth();
    _oauth.access_token = data["access_token"];
    _oauth.refresh_token = data["refresh_token"];
    _oauth.expires_in = data["expires_in"];
    _oauth.scope = data["scope"];
    int time = data["created_at"] ?? 0;
    _oauth.created_at = time;
    _resetCreatedAt(time);
    Global.profile.oauth = _oauth; //更新profile中的token信息

    prefs.setInt("expires_in", _oauth.expires_in);
    prefs.setString("access_token", _oauth.access_token);
    prefs.setString("refresh_token", _oauth.refresh_token);
    prefs.setString("scope", _oauth.scope);
    prefs.setInt("created_at", time);
    print("storeToken completed -->-->--> ${_oauth?.toString()} \n");
  }

  Future<void> resetToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("expires_in", 0);
    prefs.setString("access_token", "");
    prefs.setString("refresh_token", "");
    prefs.setString("scope", "");
    prefs.setInt("created_at", 0);
  }

  ///是否已经登录
  /// *仅判断本地是否已经存有user*
  bool get isAuthorized {
    return _oauth?.access_token != null;
  }

  ///判断是access_token是否过期
  bool get isExpired {
    if (_createdAt != null && isAuthorized) {
      return _createdAt.add(Duration(seconds: _oauth.expires_in)).isBefore(DateTime.now());
    }
    return true;
  }

  Future<bool> refreshAccessToken() async {
    print("refreshAccessToken -> ${_oauth?.refresh_token}");
    try {
      var data = await GiteeApi().refreshToken(_oauth?.refresh_token);
      print("refreshAccessToken data -> $data");
      await storeToken(data);
      return true;
    } catch (e) {
      print("refreshAccessToken Error -> $e");
      return false;
    }
  }

  DateTime _resetCreatedAt(int time) => _createdAt = DateTime.fromMillisecondsSinceEpoch(time * 1000);

  @override
  String toString() {
    return "accessToken: ${_oauth?.access_token} | refreshToken: ${_oauth?.refresh_token} "
        "| 有效期: ${_oauth.expires_in} | 创建日期：$_createdAt | 是否过期：$isExpired";
  }

  void logout() {
    resetToken();
    _createdAt = null;
    Global.profile.user = null;
    Global.profile.oauth = null;
  }
}
