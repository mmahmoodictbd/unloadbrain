import 'package:chumbok_apps/common/app_analytics.dart';
import 'package:chumbok_apps/common/app_context.dart';
import 'package:chumbok_apps/common/appbar_widget.dart';
import 'package:chumbok_apps/kobita_app/nav_drawer_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

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
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  value: Text('English'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: Icon(Icons.format_paint),
                  title: Text('Enable custom theme'),
                ),
              ],
            ),
            SettingsSection(title: Text('Developer Info'), tiles: <SettingsTile>[
              SettingsTile(title: Text('App Version'), value: Text(appConfig.getProperty('appVersion'))),
              SettingsTile(title: Text('Show Licenses'), onPressed: (value) {
                showLicensePage(context: context);
              }),
            ])
          ],
        ),
      ),
    );
  }

  void _sendAnalyticsEvent(BuildContext context) async {
    Provider.of<AppAnalytics>(context, listen: false).logVisitedScreenEvent(screenName: 'SettingsScreen');
  }
}
