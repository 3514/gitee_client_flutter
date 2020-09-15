import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../index.dart';

///码云Api
class GiteeApi {
  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  GiteeApi([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext context;
  Options _options;
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'https://gitee.com/api/v3/',
    // headers: {
    //   HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
    //       "application/vnd.github.symmetra-preview+json",
    // },
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        // 设置代理
        // client.findProxy = (uri) {
        //   return "PROXY 10.95.249.53:8888";
        // };

        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  // 登录接口，登录成功后返回用户信息
  // email 既可以是邮箱,也可以是账号名
  Future<User> login(String email, String password) async {
    //String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    final FormData formData = new FormData.fromMap({
      "email": email,
      "password": password,
    });
    var r = await dio.post(
      "/session",
      data: formData,
      options: _options.merge(headers: {
        //HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    //dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    Global.netCache.cache.clear();
    //更新profile中的token信息
    //Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  // 获取项目列表 https://gitee.com/api/v3/projects/featured/?page=1
  Future<List<RepoFeature>> getRepoList(
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
    var response = await dio.get<List>(
      "projects/$_option/",
      queryParameters: queryParameters,
      options: _options,
    );
    return response.data.map((e) => RepoFeature.fromJson(e)).toList();
  }

  //搜索仓库 https://gitee.com/api/v3/projects/search/jfinal?page=3
  Future<List<RepoFeature>> searchRepos(
      {@required String keyWords, Map<String, dynamic> queryParameters}) async {
    ///dio.request
    // _options.method = "get";
    // var response = await dio.request(
    //   "projects/search/$keyWords/",
    //   queryParameters: queryParameters,
    //   options: _options,
    // );

    var response = await dio.get<List>(
      "projects/search/$keyWords",
      queryParameters: queryParameters,
      options: _options,
    );

    return response.data.map((e) => RepoFeature.fromJson(e)).toList();
  }
}
