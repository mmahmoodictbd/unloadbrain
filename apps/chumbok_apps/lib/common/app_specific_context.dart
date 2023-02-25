import 'package:chumbok_apps/common/app_config.dart';
import 'package:chumbok_apps/common/app_router.dart';

abstract class AppSpecificContext {
  AppRouter getAppRouter();

  Future<AppConfig> getAppConfig();
}
