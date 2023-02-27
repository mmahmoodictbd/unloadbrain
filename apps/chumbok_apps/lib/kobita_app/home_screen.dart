import 'package:chumbok_apps/common/app_context.dart';
import 'package:chumbok_apps/common/appbar_widget.dart';
import 'package:chumbok_apps/kobita_app/nav_drawer_widget_builder.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _sendAnalyticsEvent(context);
    final appConfig = context.appContext.appConfig;
    return new Scaffold(
        appBar: AppBarWidget(appConfig.getProperty("appBarTitle")),
        drawer: NavDrawerWidgetBuilder(context).build(),
        body: Container(
          decoration: BoxDecoration(),
          child: Padding(padding: const EdgeInsets.all(22.0)),
        ));
  }

  Future<void> _sendAnalyticsEvent(BuildContext context) async {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context, listen: false);
    analytics.setCurrentScreen(screenName: 'HomeScreen');
    await analytics.logEvent(
      name: 'HomeScreen',
      parameters: {},
    );
  }
}
