import 'package:chumbok_apps/common/app_context.dart';
import 'package:chumbok_apps/common/navdrawer_widget.dart';
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
          NavDrawerItem(linkText: "Link1", link: "Link1", icon: FontAwesomeIcons.discord),
          NavDrawerItem(linkText: "Link2", link: "Link2", icon: FontAwesomeIcons.airbnb),
        ],
        NavDrawerAppInfoItem(
            text: "অ্যাপ ইনফো",
            appName: appConfig.getProperty('appBarTitle'),
            appVersion: appConfig.getProperty('appVersion'),
            appIcon: FontAwesomeIcons.info));
  }
}
