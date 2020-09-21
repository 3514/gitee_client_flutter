import 'dart:convert';
import 'dart:ui'; //From sky_engine 👉 https://pub.dev/packages/sky_engine
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gitee_client_flutter/common/const.dart';
import 'package:gitee_client_flutter/ui/web_view.dart';

bool checkUrl(String url) => url != null && url.startsWith("http");

Widget getAvatarCircle(
  String url, {
  double radius = 30.0,
  BoxFit fit = BoxFit.cover,
}) {
  var placeholder = Image.asset(image_avatar_default, //默认头像
      width: radius,
      height: radius);
  if (checkUrl(url)) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        width: radius,
        height: radius,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  } else {
    return ClipOval(
      child: placeholder,
    );
  }
}

Widget getAvatarRect(
  String url, {
  double width = 30.0,
  double height,
  BoxFit fit = BoxFit.cover,
  BorderRadius borderRadius,
}) {
  var placeholder = Image.asset(image_avatar_default, //默认头像
      width: width,
      height: height);

  if (checkUrl(url)) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(30),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => placeholder,
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(30),
      child: placeholder,
    );
  }
}

void showToast(
  String text, {
  gravity: ToastGravity.CENTER,
  toastLength: Toast.LENGTH_SHORT,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey[600],
    fontSize: 15.0,
  );
}

void showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(3.0), boxShadow: [
              //阴影
              BoxShadow(
                color: Colors.black12,
                //offset: Offset(2.0,2.0),
                blurRadius: 10.0,
              )
            ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

//获取当前主题色
Color getThemeColor(BuildContext context) => Theme.of(context).primaryColor;
//获取状态栏高度
double getStatusBarHeight() => MediaQueryData.fromWindow(window).padding.top;
//获取屏幕宽
double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
//获取屏幕高
double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
//Base64加密
String encodeBase64(String data) => base64Encode(utf8.encode(data));
//Base64解密
String decodeBase64(String data) => utf8.decode(base64Decode(data));

//计算文件大小
calculateFileSize(int fileByte) {
  if (fileByte < 1024) {
    return fileByte.toString() + " B";
  } else if (fileByte < 1024 * 1024) {
    return _keepDecimal(fileByte / 1024) + " KB";
  } else if (fileByte < 1024 * 1024 * 1024) {
    return _keepDecimal(fileByte / 1024 / 1024) + " M";
  } else {
    return _keepDecimal(fileByte / 1024 / 1024 / 1024) + " G";
  }
}

//保留两位小数
_keepDecimal(double data) {
  String str = data.toString();
  String decimal;
  if (str.contains('.')) {
    var arr = str.split('.');
    decimal = arr[1].toString();
    if (decimal.length > 2) {
      decimal = decimal.substring(0, 2);
    }
    return arr[0].toString() + '.' + decimal;
  } else {
    return str;
  }
}

void toast(text) => toastOriginal(text, ToastGravity.CENTER);

void toastTop(text) => toastOriginal(text, ToastGravity.TOP);

void toastBottom(text) => toastOriginal(text, ToastGravity.BOTTOM);

void toastOriginal(String text, ToastGravity gravity) {
  //Toast with No Build Context
  if (text == null) return;
  Fluttertoast.showToast(
      msg: "$text",
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 13.0);
}

navToPage(BuildContext context, String routeName, {Object arguments}) =>
    Navigator.of(context).pushNamed(routeName, arguments: arguments);

navToPage2({@required BuildContext context, @required Widget page}) => navToPage3(
      context: context,
      page: MaterialPageRoute(
        builder: (context) => page,
      ),
    );

navToPage3({@required BuildContext context, @required Route page}) => Navigator.push(
      context,
      page,
    );

navToWeb({@required BuildContext context, @required String url}) => navToPage3(
    context: context,
    page: MaterialPageRoute(
      builder: (context) => WebViewRoute(url: url),
    ));
