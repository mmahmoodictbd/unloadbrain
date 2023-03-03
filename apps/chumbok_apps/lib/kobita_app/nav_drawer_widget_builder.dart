import 'package:chumbok_apps/common/app_context.dart';
import 'package:chumbok_apps/common/navdrawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavDrawerWidgetBuilder {
  final BuildContext _buildContext;

  NavDrawerWidgetBuilder(this._buildContext);

  NavDrawerWidget build() {
    final appConfig = _buildContext.appContext.appConfig;
    return NavDrawerWidget(
        appConfig.getProperty("appLogo"),
        [
          NavDrawerItem(linkText: "Home", link: "/", icon: FontAwesomeIcons.house),
          NavDrawerItem(linkText: "Poem of the Day", link: "/poem-of-the-day", icon: FontAwesomeIcons.penNib),
          NavDrawerItem(linkText: "Settings", link: "/settings", icon: FontAwesomeIcons.gear),
        ],
        NavDrawerAppInfoItem(
            text: "App Info",
            appName: appConfig.getProperty('appBarTitle'),
            appVersion: appConfig.getProperty('appVersion'),
            appIcon: FontAwesomeIcons.circleInfo));
  }
}
