import 'package:chumbok_apps/common/app_specific_context.dart';
import 'package:chumbok_apps/history_app/history_app_specific_context.dart';
import 'package:chumbok_apps/kobita_app/kobita_app_specific_context.dart';

class AppSpecificContextFactory {
  static var _factories = <String, AppSpecificContext Function()>{
    "kobitaApp": () => KobitaAppSpecificContext(),
    "historyApp": () => HistoryAppSpecificContext()
  };

  static AppSpecificContext getAppSpecificContext(String appName) {
    if (_factories[appName] != null) {
      return _factories[appName]!();
    } else {
      throw new AssertionError("No AppSpecificContextFactory configured.");
    }
  }
}
