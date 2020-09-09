import '../index.dart';

///字体
const fontAliPuHui = 'aliPuHui';
const fontMaterialIcons = 'MaterialIcons'; //字体(内置)

///UI Router
const page_home = 'page_home';
const page_theme = 'page_theme';
const page_language = 'page_language';

final routers = {
  page_home: (context) => HomeRoute(),
  page_theme: (context) => ThemeChangeRoute(),
  page_language: (context) => LanguageRoute(),

};
