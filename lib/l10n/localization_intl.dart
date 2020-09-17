import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

class GmLocalizations {
  static Future<GmLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new GmLocalizations();
    });
  }

  static GmLocalizations of(BuildContext context) {
    return Localizations.of<GmLocalizations>(context, GmLocalizations);
  }

  String get title {
    return Intl.message(
      'Gitee',
      name: 'title',
      desc: 'Title for the Gitee application',
    );
  }

  //https://book.flutterchina.club/chapter13/intl.html
  // remainingEmailsMessage(int howMany) => Intl.plural(howMany,
  //     zero: 'There are no emails left',
  //     one: 'There is $howMany email left',
  //     other: 'There are $howMany emails left',
  //     name: "remainingEmailsMessage",
  //     args: [howMany],
  //     desc: "How many emails remain after archiving.",
  //     examples: const {'howMany': 42});

  String get home => Intl.message('Gitee', name: 'home');

  String get language => Intl.message('Language', name: 'language');

  String get login => Intl.message('Login', name: 'login');

  String get auto => Intl.message('Auto', name: 'auto');

  String get setting => Intl.message('Setting', name: 'setting');

  String get theme => Intl.message('Theme', name: 'theme');

  String get noDescription => Intl.message('No description yet !', name: 'noDescription');

  String get userName => Intl.message('User Name', name: 'userName');

  String get userNameRequired => Intl.message("User name required!", name: 'userNameRequired');

  String get password => Intl.message('Password', name: 'password');

  String get passwordRequired => Intl.message('Password required!', name: 'passwordRequired');

  String get userNameOrPasswordWrong =>
      Intl.message('User name or password is not correct!', name: 'userNameOrPasswordWrong');

  String get logout => Intl.message('logout', name: 'logout');

  String get logoutTip => Intl.message('Are you sure you want to quit your current account?', name: 'logoutTip');

  String get yes => Intl.message('yes', name: 'yes');

  String get cancel => Intl.message('cancel', name: 'cancel');

  String get navHome => Intl.message('Home', name: 'navHome');

  String get navDynamic => Intl.message('Dynamic', name: 'navDynamic');

  String get navMe => Intl.message('Me', name: 'navMe');
}

//Locale代理类
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  const GmLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['zh', 'en'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<GmLocalizations> load(Locale locale) {
    //3
    return GmLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(GmLocalizationsDelegate old) => false;
}
