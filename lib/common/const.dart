import '../index.dart';

///字体
const fontAliPuHui = 'aliPuHui';
const fontMaterialIcons = 'MaterialIcons'; //字体(内置)

///UI Router
const page_home = 'page_home';
const page_login = 'page_login';
const page_theme = 'page_theme';
const page_language = 'page_language';

final routers = {
  page_home: (context) => HomeRoute(),
  page_login: (context) => HomeRoute(),
  page_theme: (context) => ThemeChangeRoute(),
  page_language: (context) => LanguageRoute(),
};

///const tab_title_home = <String>["推荐项目", "热门项目", "最近更新"];
enum TabTitleHome {
  Recommend,
  Popular,
  Recent,
}

extension TabTitleHomeExtension on TabTitleHome {
  //eg: Recommend
  String get name => describeEnum(this);

  List<String> get _titles => <String>["推荐项目", "热门项目", "最近更新"];

  String get title => _titles.elementAt(this.index);
}

///默认头像
const image_avatar_default = "static/image/avatar-default.png";
