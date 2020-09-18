import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gitee_client_flutter/common/oauth.dart';
import '../index.dart';

class _NettingPath {
  static final login = "oauth/token";
  static final refreshToken = "oauth/token";
  static final user = "api/v5/user";
  static final repos = "api/v5/user/repos";
  static final issues = "api/v5/issues";
  static final notificationsCount = "api/v5/notifications/count";
  static final notifications = "api/v5/notifications/threads";
  static final notifyMessages = "api/v5/notifications/messages";
  static final readme = "api/v5/repos/{owner}/{repo}/readme";
  static final reposContents = "api/v5/repos/{owner}/{repo}/contents/{path}";
  static final star = "api/v5/user/starred/{owner}/{repo}";
  static final watch = "api/v5/user/subscriptions/{owner}/{repo}";
  static final starUsers = "api/v5/repos/{owner}/{repo}/stargazers";
  static final watchUsers = "api/v5/repos/{owner}/{repo}/subscribers";
}

// 码云 Api -> https://gitee.com/api/v5/swagger#/getV5UsersUsernameReceivedEvents
class GiteeApi {
  static final _ins = new GiteeApi._internal();

  factory GiteeApi() => _ins;

  GiteeApi._internal();

  Options _options = Options();
  int _perPage = 20;
  static Dio dioV3 = Dio(BaseOptions(
    baseUrl: BASE_URL_V3,
  ));
  static Dio dioV5 = Dio(BaseOptions(
    baseUrl: BASE_URL_V5,
  ));

  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  // GiteeApi([this.context]) {
  //   _options = Options(extra: {"context": context});
  // }
  //BuildContext context;

  static void init() {
    // 添加缓存插件
    dioV3.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dioV3.options.headers[HttpHeaders.authorizationHeader] = Global.profile.oauth?.access_token;

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease) {
      (dioV3.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        // 设置代理
        // client.findProxy = (uri) {
        //   return "PROXY 10.95.249.53:8888";
        // };

        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  // OAuth2 认证
  // https://gitee.com/oauth/token
  login(String account, String password) async {
    final FormData formData = new FormData.fromMap({
      "grant_type": "password",
      "username": account,
      "password": password,
      "client_id": CLIENT_ID,
      "client_secret": CLIENT_SECRET,
      //"scope": "projects user_info issues notes"
    });
    final Response response = await dioV5.post(
      _NettingPath.login,
      data: formData,
      options: _options.merge(headers: {
        //HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    Global.netCache.cache.clear(); //清空所有缓存

    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    //dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    await OAuth().storeToken(response.data);
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    Response response = await dioV5.post(_NettingPath.refreshToken, data: {
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
    });
    return response.data;
  }

  // 用户信息
  // https://gitee.com/api/v5/user?access_token=b62d8a8057c7394f34ad8e39f2061652
  Future<User> userInfo() async {
    final Response response = await dioV5.get(
      _NettingPath.user,
      queryParameters: {
        ACCESS_TOKEN: OAuth().token(),
      },
      options: _options,
    );
    // dioV5.get<User>(
    return User.fromJson(response.data); // dioV5.get(
  }

  // 获取授权用户的通知数 {"total_count":89,"notification_count":89,"message_count":0}
  // https://gitee.com/api/v5/notifications/count?access_token=b552c012800a541dac500b4f8fca1f11&unread=true
  Future<String> notificationCount(bool unread) async {
    if (!OAuth().isAuthorized) return null;
    Response response = await dioV5.get(
      _NettingPath.notificationsCount,
      queryParameters: {
        //true 未读消息
        "unread": '${unread ?? true}',
        ACCESS_TOKEN: OAuth().token(),
      },
    );
    return response.data['notification_count']?.toString();
  }

  // 列出授权用户的所有私信  https://gitee.com/api/v5/swagger#/getV5NotificationsMessages
  // https://gitee.com/api/v5/notifications/messages
  // ?access_token=c382c099d28aa30a569e4b722f579297&page=1&per_page=20&unread=false
  Future<List<NotifyMessages>> messagesAll(bool unread, {Map<String, dynamic> queryParameters}) async {
    if (!OAuth().isAuthorized) return null;

    //unread=true 未读消息 , false 全部消息
    queryParameters.addEntries({MapEntry("unread", unread)});
    queryParameters.addEntries({MapEntry(ACCESS_TOKEN, OAuth().token())});
    Response response = await dioV5.get(
        _NettingPath.notifyMessages,
        queryParameters:queryParameters
    );
    return (response.data['list'] as List).map((e) => NotifyMessages.fromJson(e)).toList();
  }

  // 列出授权用户的所有通知
  // https://gitee.com/api/v5/notifications/threads
  // ?access_token=533d2c9e8efa969583515b90af7a0664&type=all&page=1&per_page=20&unread=true
  Future<List<Notifications>> notificationsAll(bool unread, {Map<String, dynamic> queryParameters}) async {
    if (!OAuth().isAuthorized) return null;

    //unread=true 未读消息 , false 全部消息
    queryParameters.addEntries({MapEntry("unread", unread)});
    queryParameters.addEntries({MapEntry("type", "all")});
    queryParameters.addEntries({MapEntry(ACCESS_TOKEN, OAuth().token())});
    Response response = await dioV5.get(
      _NettingPath.notifications,
      queryParameters:queryParameters
    );
    return (response.data['list'] as List).map((e) => Notifications.fromJson(e)).toList();
  }

  // 获取项目列表 , 推荐项目,热门项目,最近项目
  // https://gitee.com/api/v3/projects/featured/?page=1
  Future<List<RepoV3>> getRepoList(
      {TabTitleHome tab,
      Map<String, dynamic> queryParameters, //query参数，用于接收分页信息
      refresh = false}) async {
    if (refresh) {
      // 列表下拉刷新，需要删除缓存（拦截器中会读取这些信息）
      _options.extra.addAll({"refresh": true, "list": true});
    }
    var _option = "";
    switch (tab) {
      case TabTitleHome.Recommend:
        _option = "featured";
        break;
      case TabTitleHome.Popular:
        _option = "popular";
        break;
      case TabTitleHome.Recent:
        _option = "latest";
        break;
      default:
        break;
    }
    var response = await dioV3.get<List>(
      "projects/$_option/",
      queryParameters: queryParameters,
      options: _options,
    );
    return response.data.map((e) => RepoV3.fromJson(e)).toList();
  }

  // 搜索仓库
  // https://gitee.com/api/v3/projects/search/jfinal?page=3
  @deprecated
  Future<List<RepoV3>> searchRepos({@required String keyWords, Map<String, dynamic> queryParameters}) async {
    var response = await dioV3.get<List>(
      "projects/search/$keyWords",
      queryParameters: queryParameters,
      options: _options,
    );
    return response.data.map((e) => RepoV3.fromJson(e)).toList();
  }

  Future repos(int page) async {
    if (!OAuth().isAuthorized) return null;
    Response response = await dioV5.get(
      _NettingPath.repos,
      queryParameters: {
        "perPage": _perPage,
        "page": page,
        "sort": "created",
        ACCESS_TOKEN: OAuth().token(),
      },
    );
    return response.data;
  }

  Future issues(int page) async {
    if (!OAuth().isAuthorized) return null;
    Response response = await dioV5.get(
      _NettingPath.issues,
      queryParameters: {
        "perPage": _perPage,
        "page": page,
        "sort": "updated",
        "filter": "all",
        "state": "all",
        ACCESS_TOKEN: OAuth().token(),
      },
    );
    return response.data;
  }

  Future readme(String owner, String repo) async {
    Response response = await dioV5.get(
      _NettingPath.readme,
      queryParameters: {
        "{owner}": owner,
        "{repo}": repo,
        ACCESS_TOKEN: OAuth().token(),
      },
    );
    return response.data;
  }

  Future reposContents(String owner, String repo, {String path: "", String ref}) async {
    var data = {
      "{owner}": owner,
      "{repo}": repo,
      "{path}": path,
      ACCESS_TOKEN: OAuth().token(),
    };
    if (ref != null) {
      data["ref"] = ref;
    }
    Response response = await dioV5.get(_NettingPath.reposContents, queryParameters: data);
    return response.data;
  }

  Future updateProfile(Map<String, dynamic> data) async {
    Map<String, dynamic> _data = {
      ACCESS_TOKEN: OAuth().token(),
    };
    _data.addAll(data);
    Response response = await dioV5.patch(_NettingPath.user, queryParameters: _data);
    return response.data;
  }

  Future star(String owner, String repo) async {
    var data = {
      "{owner}": owner,
      "{repo}": repo,
      ACCESS_TOKEN: OAuth().token(),
    };
    print(data);
    Response response = await dioV5.put(_NettingPath.star, queryParameters: data);
    return response.data;
  }

  Future unstar(String owner, String repo) async {
    var data = {
      "{owner}": owner,
      "{repo}": repo,
      ACCESS_TOKEN: OAuth().token(),
    };
    print(data);
    Response response = await dioV5.delete(_NettingPath.star, queryParameters: data);
    return response.data;
  }

  Future watch(String owner, String repo) async {
    Map<String, dynamic> data = {
      "{owner}": owner,
      "{repo}": repo,
      ACCESS_TOKEN: OAuth().token(),
    };
    print(data);
    Response response = await dioV5.put(_NettingPath.watch, queryParameters: data);
    return response.data;
  }

  Future unwatch(String owner, String repo) async {
    var data = {
      "{owner}": owner,
      "{repo}": repo,
      ACCESS_TOKEN: OAuth().token(),
    };
    print(data);
    Response response = await dioV5.delete(_NettingPath.watch, queryParameters: data);
    return response.data;
  }

  Future<dynamic> starUsers(String owner, String repo, [int page = 1]) async {
    var data = {
      "{owner}": owner,
      "{repo}": repo,
      "per_page": _perPage,
      "page": page,
      ACCESS_TOKEN: OAuth().token(),
    };
    Response response = await dioV5.get(_NettingPath.starUsers, queryParameters: data);
    return response.data;
  }

  Future<dynamic> watchUsers(String owner, String repo, [int page = 1]) async {
    var data = {
      "{owner}": owner,
      "{repo}": repo,
      "per_page": _perPage,
      "page": page,
      ACCESS_TOKEN: OAuth().token(),
    };
    Response response = await dioV5.get(_NettingPath.watchUsers, queryParameters: data);
    return response.data;
  }
}
