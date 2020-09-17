import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/single_child_widget.dart';
import 'index.dart';

void main() => Global.init().then((v) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
        ChangeNotifierProvider.value(value: UserModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
          builder: (BuildContext context, themeModel, localeModel, Widget child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: themeModel.theme,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateTitle: (context) {
            return GmLocalizations.of(context).title;
          },
          home: LaunchWidget(),

          ///语言
          locale: localeModel.getLocale(),
          supportedLocales: [
            const Locale('zh', 'CN'), //中文简体
            const Locale('en', 'US'), //美国英语
            //...
          ],
          //本地化的代理类
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GmLocalizationsDelegate()
            //...
          ],
          localeResolutionCallback: (Locale _locale, Iterable<Locale> supportedLocales) {
            if (localeModel.getLocale() != null) {
              return localeModel.getLocale(); //使用上次设置的语言, 不跟随系统
            } else {
              //默认跟随系统
              Locale locale;
              if (supportedLocales.contains(_locale)) {
                locale = _locale;
              } else {
                //如果系统语言不是中文简体或美国英语，则默认使用中文简体
                locale = Locale('zh', 'CN');
              }
              return locale;
            }
          },

          ///注册命名路由表
          routes: routers,
        );
      }),
    );
  }
}
