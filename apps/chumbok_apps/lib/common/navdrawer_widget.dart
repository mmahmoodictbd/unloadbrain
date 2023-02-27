import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawerWidget extends StatelessWidget {
  const NavDrawerWidget(this.appLogoPath, this.items, this.appInfoItem);

  final String appLogoPath;
  final List<NavDrawerItem> items;
  final NavDrawerAppInfoItem appInfoItem;

  @override
  Widget build(BuildContext context) {
    return new Drawer(child: Container(child: ListView(children: _prepareNavDrawerItems(context, items, appInfoItem))));
  }

  List<Widget> _prepareNavDrawerItems(
      BuildContext context, List<NavDrawerItem> items, NavDrawerAppInfoItem appInfoItem) {
    List<Widget> lst = [];
    lst.add(_navDrawerHeader(context));
    lst.add(SizedBox(height: 15.0));
    items.forEach(
        (drawerItem) => lst.add(_buildNavLinkItem(context, drawerItem.icon, drawerItem.linkText, drawerItem.link)));
    lst.add(_navDrawerAppInfo(appInfoItem));
    return lst;
  }

  DrawerHeader _navDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
        child: OverflowBox(
          minWidth: 0.0,
          minHeight: 0.0,
          maxWidth: double.infinity,
          child: Image.asset(appLogoPath, fit: BoxFit.contain),
        ),
      ),
    );
  }

  ListTile _buildNavLinkItem(BuildContext context, icon, String text, String link) {
    return ListTile(
        leading: Icon(icon),
        title: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onTap: () {
          _sendNavLinkClickedAnalyticsEvent(context, text, link);
          _launchUrl(link);
        },
        horizontalTitleGap: 0);
  }

  AboutListTile _navDrawerAppInfo(NavDrawerAppInfoItem appInfoItem) {
    return AboutListTile(
      child: Transform.translate(
          offset: Offset(-16, 0),
          child: Text(
            appInfoItem.text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      applicationName: appInfoItem.appName,
      applicationVersion: appInfoItem.appVersion,
      applicationIcon: Icon(Icons.adb),
      dense: true,
      icon: Icon(appInfoItem.appIcon),
    );
  }

  Future<void> _sendNavLinkClickedAnalyticsEvent(BuildContext context, String text, String link) async {
    FirebaseAnalytics analytics = Provider.of<FirebaseAnalytics>(context, listen: false);
    analytics.setCurrentScreen(screenName: 'NavbarScreen');
    await analytics.logEvent(
      name: 'NavLinkClicked',
      parameters: <String, dynamic>{'text': text, 'link': link},
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

class NavDrawerItem {
  final String linkText;
  final String link;
  final IconData icon;

  NavDrawerItem({required this.linkText, required this.link, required this.icon});
}

class NavDrawerAppInfoItem {
  final String text;
  final String appName;
  final String appVersion;
  final IconData appIcon;

  NavDrawerAppInfoItem({required this.text, required this.appName, required this.appVersion, required this.appIcon});
}
