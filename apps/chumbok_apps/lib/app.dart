import 'package:chumbok_apps/common/app_context.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  static FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver _observer = FirebaseAnalyticsObserver(analytics: _analytics);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAnalytics>.value(value: _analytics),
          Provider<FirebaseAnalyticsObserver>.value(value: _observer),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: context.appContext.appConfig.getProperty('appBarTitle'),
            theme: context.appContext.appThemeData,
            navigatorObservers: <NavigatorObserver>[_observer],
            onGenerateRoute: (RouteSettings settings) {
              return settings.name == '/' ? context.appContext.appRouter.generateRoute('/') : null;
            },
        ));
  }
}
