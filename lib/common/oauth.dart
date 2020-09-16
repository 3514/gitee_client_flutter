import '../index.dart';

class OAuth {
  static final OAuth _shared = new OAuth._internal();

  OAuth._internal();

  factory OAuth() {
    return _shared;
  }

  int expiresIn = 0;
  String refreshToken;
  DateTime createdAt;
  String accessToken;
  User user;

  void updateUser(User newUser) {
    user = newUser;
  }

  ///程序启动时调用，检查本地用户信息
  Future prepare() async {
    // Netting().loginObservable.listen((data) {
    //   _storeToken(data);
    // });
    // Netting().userObservable.map((data) => User.fromJson(data)).listen((data) => user = data);

    if (accessToken == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString("access_token");
      refreshToken = prefs.getString("refresh_token");
      expiresIn = prefs.getInt("expires_in") ?? 0;
      createdAt = DateTime.fromMillisecondsSinceEpoch((prefs.getInt("created_at") ?? 0) * 1000);
    }
    print("可访问:${!isExpired}");
    return this;
  }

  Future<void> _storeToken(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = data["access_token"];
    refreshToken = data["refresh_token"];
    expiresIn = data["expires_in"];
    int time = data["created_at"] ?? 0;
    createdAt = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    prefs.setInt("expires_in", expiresIn);
    prefs.setString("access_token", accessToken);
    prefs.setString("refresh_token", refreshToken);
    prefs.setInt("created_at", time);
    print("肯定可访问");
  }

  ///是否已经登录
  /// *仅判断本地是否已经存有user*
  bool get isAuthorized {
    return accessToken != null;
  }

  ///判断是access_token是否过期
  bool get isExpired {
    if (createdAt != null && isAuthorized) {
      return createdAt.add(new Duration(seconds: expiresIn)).isBefore(new DateTime.now());
    } else {
      return true;
    }
  }

  Future<bool> refreshAccessToken() async {
    try {
      var data = await GiteeApi().refreshToken(refreshToken);
      print(data);
      await _storeToken(data);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  String toString() {
    return "accessToken: $accessToken | refreshToken: $refreshToken | 有效期: $expiresIn | 创建日期：$createdAt | 是否过期：$isExpired";
  }

  void logout() {
    refreshToken = null;
    accessToken = null;
    expiresIn = 0;
  }
}
