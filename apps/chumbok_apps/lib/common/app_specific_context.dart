import 'package:chumbok_apps/common/app_config.dart';
import 'package:chumbok_apps/common/app_router.dart';
import 'package:chumbok_apps/common/app_theme.dart';

abstract class AppSpecificContext {
  AppRouter getAppRouter();

  Future<AppConfig> getAppConfig();

  Future<AppTheme> getAppTheme();
}
