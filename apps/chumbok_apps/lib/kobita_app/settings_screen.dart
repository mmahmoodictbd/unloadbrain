import 'package:chumbok_apps/common/app_analytics.dart';
import 'package:chumbok_apps/common/app_context.dart';
import 'package:chumbok_apps/common/appbar_widget.dart';
import 'package:chumbok_apps/kobita_app/nav_drawer_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _sendAnalyticsEvent(context);
    final appConfig = context.appContext.appConfig;
    return new Scaffold(
        appBar: AppBarWidget("Settings"),
        drawer: NavDrawerWidgetBuilder(context).build(),
        body: Container(
          decoration: BoxDecoration(),
          child: Padding(padding: const EdgeInsets.all(22.0)),
        ));
  }

  void _sendAnalyticsEvent(BuildContext context) async {
    Provider.of<AppAnalytics>(context, listen: false).logVisitedScreenEvent(screenName: 'SettingsScreen');
  }
}
