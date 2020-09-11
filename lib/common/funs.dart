import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gitee_client_flutter/common/const.dart';

Widget getAvatarCircle(
  String url, {
  double radius = 30.0,
  BoxFit fit = BoxFit.cover,
}) {
  var placeholder = Image.asset(image_avatar_default, //默认头像
      width: radius,
      height: radius);
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
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

//获取屏幕宽
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//获取屏幕高
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//Base64加密
String encodeBase64(String data) {
  var content = utf8.encode(data);
  return base64Encode(content);
}

//Base64解密
String decodeBase64(String data) {
  return utf8.decode(base64Decode(data));
}
