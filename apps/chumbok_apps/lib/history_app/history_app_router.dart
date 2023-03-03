import 'package:chumbok_apps/common/app_default_router.dart';
import 'package:flutter/material.dart';

class HistoryAppRouter extends AppDefaultRouter {
  static const String homeScreenRoute = '/';
  static const String aboutUsScreenRoute = '/about-us';

  @override
  Route generateRoute(String path) {
    var _settings = RouteSettings(name: path);
    switch (path) {
      default:
        return MaterialPageRoute(settings: _settings, builder: (_) => defaultScreen(path));
    }
  }
}
