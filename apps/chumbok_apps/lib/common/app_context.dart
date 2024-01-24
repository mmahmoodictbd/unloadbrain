import 'package:chumbok_apps/common/app_config.dart';
import 'package:chumbok_apps/common/app_theme.dart';
import 'package:flutter/material.dart';

import '../app_specific_context_factory.dart';
import 'app_router.dart';
import 'app_specific_context.dart';

class AppContext {
  static final Map<String, dynamic> _internalVariables = {};
  static late AppSpecificContext _appSpecificContext;
  static late AppRouter _appRouter;
  static late AppConfig _appConfig;
  static late AppTheme _appTheme;
  static late ThemeData _appThemeData;
  static late AppContext _instance;

  static AppContext get instance {
    return _instance;
  }

  static Future<AppContext> init() async {
    _determineAppName();
    _loadAppSpecificContext();
    _appRouter = _appSpecificContext.getAppRouter();
    _appConfig = await _appSpecificContext.getAppConfig();
    _appTheme = await _appSpecificContext.getAppTheme();
    _appThemeData = _appTheme.themeData;
    _instance = AppContext._internal();
    return _instance;
  }

  AppContext._internal();

  static void _determineAppName() {
    const appName = String.fromEnvironment('appName');
    if (appName.isEmpty) {
      throw new AssertionError("No 'appName' selected. Add --dart-define=appName=<APP_NAME>");
    }
    _internalVariables.putIfAbsent("appName", () => appName);
  }

  static void _loadAppSpecificContext() {
    _appSpecificContext = AppSpecificContextFactory.getAppSpecificContext(appName);
  }

  static String get appName => _internalVariables["appName"];

  AppRouter get appRouter => _appRouter;

  AppConfig get appConfig => _appConfig;

  ThemeData get appThemeData => _appThemeData;
}

extension AppContextOnBuildContext on BuildContext {
  AppContext get appContext => AppContext.instance;
}
