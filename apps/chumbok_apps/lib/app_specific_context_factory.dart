import 'package:chumbok_apps/kobita_app/kobita_app_specific_context.dart';

import 'common/app_specific_context.dart';
import 'history_app/history_app_specific_context.dart';

class AppSpecificContextFactory {
  static var _factories = <String, AppSpecificContext Function()>{
    "kobitaApp": () => KobitaAppSpecificContext(),
    "historyApp": () => HistoryAppSpecificContext()
  };

  static AppSpecificContext getAppSpecificContext(String appName) {
    if (_factories[appName] != null) {
      return _factories[appName]!();
    } else {
      throw new Exception("No AppSpecificContextFactory configured.");
    }
  }
}
