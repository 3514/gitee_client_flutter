import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new _MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class _MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) => <String, Function>{
        "auto": MessageLookupByLibrary.simpleMessage("Auto"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "home": MessageLookupByLibrary.simpleMessage("Gitee"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "logout": MessageLookupByLibrary.simpleMessage("logout"),
        "logoutTip": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to quit your current account?"),
        "noDescription": MessageLookupByLibrary.simpleMessage("No description yet !"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordRequired": MessageLookupByLibrary.simpleMessage("Password required!"),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "title": MessageLookupByLibrary.simpleMessage("Gitee App"),
        "userName": MessageLookupByLibrary.simpleMessage("User Name"),
        "userNameOrPasswordWrong":
            MessageLookupByLibrary.simpleMessage("User name or password is not correct!"),
        "userNameRequired": MessageLookupByLibrary.simpleMessage("User name required!"),
        "yes": MessageLookupByLibrary.simpleMessage("yes")
      };
}
