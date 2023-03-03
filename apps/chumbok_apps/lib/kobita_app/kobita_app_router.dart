import 'package:chumbok_apps/common/app_default_router.dart';
import 'package:chumbok_apps/kobita_app/poem_of_the_day_screen.dart';
import 'package:chumbok_apps/kobita_app/settings_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class KobitaAppRouter extends AppDefaultRouter {
  static const String homeScreenRoute = '/';
  static const String settingsScreenRoute = '/settings';
  static const String poemOfTheDayScreenRoute = '/poem-of-the-day';
  static const String aboutUsScreenRoute = '/about-us';

  @override
  Route generateRoute(path) {
    var _settings = RouteSettings(name: path);
    switch (path) {
      case homeScreenRoute:
        return MaterialPageRoute(settings: _settings, builder: (_) => const HomeScreen());
      case poemOfTheDayScreenRoute:
        return MaterialPageRoute(settings: _settings, builder: (_) => const PoemOfTheDayScreen());
      case settingsScreenRoute:
        return MaterialPageRoute(settings: _settings, builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(settings: _settings, builder: (_) => defaultScreen(path));
    }
  }
}
