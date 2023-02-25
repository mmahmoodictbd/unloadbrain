import 'package:chumbok_apps/common/app_config.dart';
import 'package:chumbok_apps/common/app_router.dart';
import 'package:chumbok_apps/common/app_specific_context.dart';
import 'package:chumbok_apps/history_app/history_app_router.dart';

class HistoryAppSpecificContext implements AppSpecificContext {
  @override
  AppRouter getAppRouter() {
    return HistoryAppRouter();
  }

  @override
  Future<AppConfig> getAppConfig() {
    return AppConfig('assets/history_app/config/appConfig.yaml').init();
  }
}
