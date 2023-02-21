import 'package:chumbok_apps/common/app_default_router.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class KobitaAppRouter extends AppDefaultRouter {
  static const String homeScreenRoute = '/';
  static const String aboutUsScreenRoute = '/about-us';

  @override
  Route generateRoute(path) {
    switch (path) {
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => defaultScreen(path));
    }
  }
}
