import 'package:chumbok_apps/common/app_default_router.dart';
import 'package:flutter/material.dart';

class HistoryAppRouter extends AppDefaultRouter {
  static const String homeScreenRoute = '/';
  static const String aboutUsScreenRoute = '/about-us';

  @override
  Route generateRoute(String path) {
    switch (path) {
      default:
        return MaterialPageRoute(builder: (_) => defaultScreen(path));
    }
  }
}
