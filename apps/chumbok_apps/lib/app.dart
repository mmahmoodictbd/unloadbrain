import 'package:chumbok_apps/common/app_analytics.dart';
import 'package:chumbok_apps/common/app_context.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver _observer = FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Widget build(BuildContext context) {
    var _appName = context.appContext.appConfig.getProperty('appName');
    var _appBarTitle = context.appContext.appConfig.getProperty('appBarTitle');
    return MultiProvider(
        providers: [Provider<AppAnalytics>.value(value: AppAnalytics(_appName, _analytics))],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _appBarTitle,
          theme: context.appContext.appThemeData,
          navigatorObservers: <NavigatorObserver>[_observer],
          onGenerateRoute: (RouteSettings settings) {
            return settings.name == '/' ? context.appContext.appRouter.generateRoute('/') : null;
          },
        ));
  }
}
